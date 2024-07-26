import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authManager: AuthViewModel
    @StateObject var tabModel = TabBarViewModel()
    
    var body: some View {
        if authManager.isLoggedIn {
            VStack(spacing: 0) {
                Spacer()
                switch tabModel.selectedTab {
                    
                case 0:
                    MatchesView()
                        .environmentObject(authManager)
                    
                case 1:
                    ShopView()
                    
                case 2:
                    ProfileView()
                        .environmentObject(authManager)
                    
                default:
                    Text("Selection inconnue")
                }
                
                Spacer()
                CustomTabBar(viewModel: tabModel)
            }
            .padding(.horizontal, 12)
            .background(Color.customBlack)
        } else {
            SignUpView()
                .environmentObject(authManager)
        }
    }
}
