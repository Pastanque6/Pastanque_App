import Foundation
import FirebaseFirestore

class MyBetsModel: ObservableObject {
    @Published var userBets: [Bet] = []
    @Published var showAlert = false
    @Published var alertMessage = ""

    private var authViewModel: AuthViewModel

    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
    }

    func fetchUserBets() {
        guard let userId = authViewModel.user?.id else {
            self.alertMessage = "User not authenticated."
            self.showAlert = true
            return
        }

        let db = Firestore.firestore()
        db.collection("bets")
            .whereField("userId", isEqualTo: userId)
            .order(by: "createdAt", descending: true)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Failed to fetch bets: \(error.localizedDescription)")
                    self.alertMessage = "Failed to fetch bets: \(error.localizedDescription)"
                    self.showAlert = true
                    return
                }

                guard let documents = querySnapshot?.documents else {
                    print("No bets found")
                    self.alertMessage = "No bets found."
                    self.showAlert = true
                    return
                }

                let fetchedBets = documents.compactMap { document -> Bet? in
                    do {
                        let bet = try document.data(as: Bet.self)
                        return bet
                    } catch {
                        print("Failed to decode bet: \(error)")
                        return nil
                    }
                }

                DispatchQueue.main.async {
                    self.userBets = fetchedBets
                }
            }
    }
}
