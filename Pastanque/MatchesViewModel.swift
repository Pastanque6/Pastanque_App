import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class MatchesViewModel: ObservableObject {
    @Published var matches: [Match] = []
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
                    guard let match = try? document.data(as: Match.self) else {
                        return nil
                    }
                    
                    // Convert commenceTime to Date
                    guard let commenceDate = ISO8601DateFormatter().date(from: match.commenceTime) else {
                        return nil
                    }
                    
                    // Filter out matches without odds and matches that have already started
                    let hasOdds = match.odds.homeTeam != nil || match.odds.awayTeam != nil || match.odds.draw != nil
                    let hasNotStarted = commenceDate > now
                    return (hasOdds && hasNotStarted) ? match : nil
                }
                
                // Update the matches on the main thread
                DispatchQueue.main.async {
                    self.matches = filteredMatches
                }
            }
    }
}
