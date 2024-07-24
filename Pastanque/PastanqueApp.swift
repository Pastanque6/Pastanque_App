import SwiftUI
import Firebase

@main
struct PastanqueApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
                ContentView()
                .environmentObject(AuthViewModel())
                .environmentObject(MatchesViewModel())
                .environmentObject(LeaguesViewModel())
        }
    }
}
