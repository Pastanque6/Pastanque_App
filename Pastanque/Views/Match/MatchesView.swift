import SwiftUI

struct MatchesView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var matchesViewModel: MatchesViewModel

    var body: some View {
        VStack {
            Text("Welcome, \(authViewModel.user?.username ?? "User")!")
                .font(.largeTitle)
                .padding()
            
            MatchFilterList(viewModel: matchesViewModel)
            
            MatchesList()
            
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
        .padding(.horizontal, 12)

    }
}
