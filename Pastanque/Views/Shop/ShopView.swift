import SwiftUI

struct ShopView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var selectedSport: String = SportsConfig.sportsOrder.first ?? "soccer"

    var body: some View {
        VStack(spacing: 12) {
            SegmentedControl(selectedSport: $selectedSport, availableSports: authViewModel.availableSports)
            
            LeagueCardList(leagues: authViewModel.leaguesBySport[selectedSport] ?? [], unlockedLeagues: authViewModel.user?.unlockedLeagues ?? []) { leagueKey in
                authViewModel.purchaseLeague(leagueKey: leagueKey) { success in
                    if success {
                        print("\(leagueKey) purchased successfully.")
                    } else {
                        print("Failed to purchase \(leagueKey): \(authViewModel.errorMessage ?? "Unknown error")")
                    }
                }
            }
            .onAppear {
                authViewModel.fetchAvailableLeagues {
                    self.selectedSport = authViewModel.availableSports.first ?? "soccer"
                }
            }
        }
        .padding(.top, 4)
    }
}
