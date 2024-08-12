import SwiftUI

struct AuthenticatedView: View {
    @EnvironmentObject var authManager: AuthViewModel
    @ObservedObject var tabModel: TabBarViewModel
    @ObservedObject var matchesViewModel: MatchesViewModel
    @Binding var showingProfile: Bool

    private var currentCurrencyType: CurrencyType {
        switch tabModel.selectedTab {
        case 0, 1:
            return .credits
        case 2:
            return .gems
        default:
            return .credits
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(currencyType: currentCurrencyType, avatar: authManager.user?.avatar ?? "avatar1", username: authManager.user?.username ?? "", gems: authManager.user?.gems ?? 0, credits: authManager.user?.credits ?? 0, showingProfile: $showingProfile) {
                VStack(spacing: 0) {
                    Spacer()
                    switch tabModel.selectedTab {
                    case 0:
                        MatchesView(viewModel: matchesViewModel)
                            .environmentObject(authManager)
                    case 1:
                        MyBetsView(authViewModel: authManager)
                    case 2:
                        ShopView()
                    default:
                        Text("Selection inconnue")
                    }
                    Spacer()
                    CustomTabBar(viewModel: tabModel)
                }
                .padding(.horizontal, 12)
                .background(Color.customBlack)
            }
            .onAppear {
                tabModel.selectedTab = 0
            }
        }
    }
}
