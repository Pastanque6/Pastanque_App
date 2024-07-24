import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var username: String = ""
    @State private var phoneNumber: String = ""
    @State private var selectedLeague: String = ""
    @State private var availableLeagues: [String] = []
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
            TextField("Phone Number", text: $phoneNumber)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
            Picker("Select a League", selection: $selectedLeague) {
                ForEach(availableLeagues, id: \.self) { league in
                    Text(league).tag(league)
                }
            }
            .padding()
            .onAppear {
                // Fetch available leagues
                authViewModel.fetchAvailableLeagues { leagues in
                    self.availableLeagues = leagues
                    self.selectedLeague = leagues.first ?? ""
                }
            }
            
            Button(action: {
                authViewModel.signUp(username: username, phoneNumber: phoneNumber, selectedLeague: selectedLeague) { success in
                    if success {
                        print("Sign up successful")
                    } else {
                        print("Sign up failed: \(authViewModel.errorMessage ?? "Unknown error")")
                    }
                }
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            
            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
}
