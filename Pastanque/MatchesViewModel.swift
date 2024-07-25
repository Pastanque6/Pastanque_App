import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class MatchesViewModel: ObservableObject {
    @Published var matches: [Match] = []
    @Published var selectedOddsForMatch: [String: String] = [:]
    
    private var db = Firestore.firestore()
    
    func fetchMatches(for unlockedLeagues: [String]) {
        let now = Date()
        
        db.collection("matches")
            .whereField("sport_key", in: unlockedLeagues)
            .order(by: "commence_time", descending: false) // Order by commence time ascending
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
                
                
                // Update the matches on the main thread
                DispatchQueue.main.async {
                    self.matches = filteredMatches
                }
            }
    }
    func toggleSelectedOdd(forMatch matchId: String, withOddId oddId: String) {
        if selectedOddsForMatch[matchId] == oddId {
            selectedOddsForMatch[matchId] = nil
        } else {
            selectedOddsForMatch[matchId] = oddId
        }
    }
}
