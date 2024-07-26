import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var username: String = ""
    @State private var phoneNumber: String = ""
    @State private var selectedLeagueId: String? = nil
    @State private var selectedSport: String = SportsConfig.sportsOrder.first ?? "soccer"
    
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
            
            SegmentedControl(selectedSport: $selectedSport, availableSports: authViewModel.availableSports)
                .padding(.vertical)
            
            FreeLeagueList(leagues: authViewModel.leaguesBySport[selectedSport] ?? [], selectedLeagueKey: $selectedLeagueId)
                .onAppear {
                    authViewModel.fetchAvailableLeagues {
                        self.selectedSport = authViewModel.availableSports.first ?? "soccer"
                        if let defaultLeagues = authViewModel.leaguesBySport[self.selectedSport] {
                            self.selectedLeagueId = defaultLeagues.first?.id
                        }
                    }
                }
            
            Button(action: {
                authViewModel.signUp(username: username, phoneNumber: phoneNumber, selectedLeague: selectedLeagueId ?? "") { success in
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
        .padding(.horizontal, 12)
        .background(Color.customBlack)
    }
}
