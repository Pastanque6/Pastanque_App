import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authManager: AuthViewModel
    
    var body: some View {
        if authManager.isLoggedIn {
            MainView()
                .environmentObject(authManager)
        } else {
            SignUpView()
                .environmentObject(authManager)
                .environmentObject(LeaguesViewModel())
        }
    }
}
