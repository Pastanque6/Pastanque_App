import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authManager: AuthViewModel
    @StateObject var tabModel = TabBarViewModel()
    @StateObject var matchesViewModel = MatchesViewModel()
    @State private var showingProfile = false
    
    var body: some View {
        if authManager.isLoggedIn {
            AuthenticatedView(tabModel: tabModel, matchesViewModel: matchesViewModel, showingProfile: $showingProfile)
                .sheet(isPresented: $showingProfile) {
                    ProfileView(isPresented: $showingProfile)
                        .environmentObject(authManager)
                }
        } else {
                SignUpFlow()
                    .environmentObject(authManager)
        }
    }
}
