import SwiftUI
import FirebaseFirestore

class LeaguesViewModel: ObservableObject {
    @Published var availableLeagues: [String] = []

    private var db = Firestore.firestore()

    func fetchAvailableLeagues() {
        db.collection("leagues").whereField("available", isEqualTo: true).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching leagues: \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                self.availableLeagues = snapshot?.documents.compactMap { $0["name"] as? String } ?? []
            }
        }
    }
}
