import SwiftUI
import FirebaseFirestore

struct MyBetsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var myBetsModel: MyBetsModel
    @State private var selectedFilter: BetFilterType = .inProgress

    init(authViewModel: AuthViewModel) {
        self._myBetsModel = StateObject(wrappedValue: MyBetsModel(authViewModel: authViewModel))
    }

    var body: some View {
        VStack {
            BetFilterList(selectedFilter: $selectedFilter)
            
            ZStack {
                if filteredBets().isEmpty {
                    VStack {
                        Spacer()
                        Text("Aucun pari")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                } else {
                    BetCardList(bets: filteredBets())
                }
            }
        }
        .alert("Erreur", isPresented: $myBetsModel.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(myBetsModel.alertMessage)
        }
        .onAppear {
            myBetsModel.fetchUserBets()
        }
    }

    private func filteredBets() -> [Bet] {
        let sortedBets = myBetsModel.userBets.sorted { $0.createdAt > $1.createdAt }
        
        switch selectedFilter {
        case .inProgress:
            let inProgressBets = sortedBets.filter { $0.betStatus == "pending" }
            return inProgressBets
        case .won:
            let wonBets = sortedBets.filter { $0.betStatus == "won" }
            return wonBets
        case .over:
            let overBets = sortedBets.filter { $0.betStatus == "won" || $0.betStatus == "lost" }
            return overBets
        }
    }
}
