import SwiftUI

struct MainView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var matchViewModel: MatchesViewModel
    
    var body: some View {
        VStack {
            Text("Welcome, \(authViewModel.user?.username ?? "User")!")
                .font(.largeTitle)
                .padding()
            
            MatchesView()
            
            Button(action: {
                authViewModel.logout()
            }) {
                Text("Logout")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .padding()
        }
    }
}
