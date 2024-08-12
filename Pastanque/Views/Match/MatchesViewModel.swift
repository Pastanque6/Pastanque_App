import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class MatchesViewModel: ObservableObject {
    @Published var matches: [Match] = []
    @Published var selectedLeague: String? = nil
    @Published var selectedOddsForMatch: [String: String] = [:]
    @Published var leagues: [String] = []

    private var db = Firestore.firestore()
    
    func fetchMatches(for unlockedLeagues: [String]) {
        let now = Date()
        
        db.collection("matches")
            .whereField("sport_key", in: unlockedLeagues)
            .order(by: "commence_time", descending: false)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }
                
                // Parse and filter the matches
                let filteredMatches = documents.compactMap { document -> Match? in
                    // Parse the document into a Match object
                    do {
                        var match = try document.data(as: Match.self)
                        
                        // Vérifiez que l'ID est bien présent
                        if match.id == nil {
                            match.id = document.documentID
                        }
                        
                        // Filter out matches without odds and matches that have already started
                        let hasOdds = match.odds.homeTeam != nil || match.odds.awayTeam != nil || match.odds.draw != nil
                        let hasNotStarted = match.matchTime > now
                        return (hasOdds && hasNotStarted) ? match : nil
                    } catch {
                        print("Failed to parse document: \(document.data())")
                        return nil
                    }
                }
                
                // Extract leagues from the filtered matches
                let leaguesSet = Set(filteredMatches.map { $0.leagueName })
                let leagues = Array(leaguesSet)
                
                // Update the matches and leagues on the main thread
                DispatchQueue.main.async {
                    self.matches = filteredMatches
                    self.leagues = leagues
                }
            }
    }
    
    var filteredMatches: [Match] {
        if let selectedLeague = selectedLeague {
            return matches.filter { $0.leagueName == selectedLeague }
        } else {
            return matches
        }
    }
    
    var oddsProduct: Double {
        selectedOddsForMatch.reduce(1.0) { currentProduct, selection in
            let (matchId, oddId) = selection
            
            guard let match = matches.first(where: { $0.id == matchId }),
                  let oddValue = match.odds.oddsForId(oddId) else {
                return currentProduct
            }
    
            return currentProduct * oddValue
        }
    }
    
    func toggleSelectedOdd(forMatch matchId: String, withOddId oddId: String) {
        if selectedOddsForMatch[matchId] == oddId {
            selectedOddsForMatch.removeValue(forKey: matchId)
        } else {
            selectedOddsForMatch[matchId] = oddId
        }
    }
    
    func clearAllSelectedOdds() {
        selectedOddsForMatch.removeAll()
    }
}

extension MatchesViewModel {
    var selectedMatchesAndOdds: [(match: Match, odd: Odds.OddDetail)] {
        var selectedMatchesAndOdds = [(Match, Odds.OddDetail)]()
        
        for (matchId, oddId) in selectedOddsForMatch {
            if let match = matches.first(where: { $0.id == matchId }),
               let odd = match.odds.detailForId(oddId) {
                selectedMatchesAndOdds.append((match, odd))
            }
        }
        
        return selectedMatchesAndOdds
    }
}

extension Odds {
    func oddsForId(_ id: String) -> Double? {
        switch id {
        case homeTeam?.id:
            return homeTeam?.value
        case draw?.id:
            return draw?.value
        case awayTeam?.id:
            return awayTeam?.value
        default:
            return nil
        }
    }

    func detailForId(_ id: String) -> OddDetail? {
        switch id {
        case homeTeam?.id:
            return homeTeam
        case draw?.id:
            return draw
        case awayTeam?.id:
            return awayTeam
        default:
            return nil
        }
    }

    func labelForId(_ id: String) -> String? {
        switch id {
        case homeTeam?.id:
            return homeTeam?.label
        case draw?.id:
            return draw?.label
        case awayTeam?.id:
            return awayTeam?.label
        default:
            return nil
        }
    }
}
