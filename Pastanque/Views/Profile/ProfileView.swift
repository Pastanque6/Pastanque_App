import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack {
            Text("Welcome, \(authViewModel.user?.username ?? "User")!")
                .font(.largeTitle)
                .padding()

            if let user = authViewModel.user {
                Text("Credits: \(user.credits, specifier: "%.2f")")
                    .font(.headline)
                    .padding(.top, 8)
                Text("Gems: \(user.gems)")
                    .font(.headline)
                    .padding(.top, 8)
            } else {
                Text("Loading user data...")
                    .font(.headline)
                    .padding(.top, 8)
            }

            Spacer()

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
        .padding()
    }
}
