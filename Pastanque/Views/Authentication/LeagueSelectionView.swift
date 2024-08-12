import SwiftUI

struct LeagueSelectionView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var selectedSport: String = SportsConfig.sportsOrder.first ?? "soccer"
    
    var body: some View {
        VStack (spacing: 32) {
            VStack(spacing: 16) {
                
                HStack {
                    Text("Championnat")
                        .font(.custom(FontStyles.medium, size: FontStyles.big))
                        .foregroundColor(Color.customWhite)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack(spacing: 4) {
                    Text("On t’offre ton premier championnat sur lequel parier, choisis bien !")
                        .font(.custom(FontStyles.light, size: FontStyles.small))
                        .foregroundColor(Color.grey100)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Tu pourras en débloquer d’autres par la suite.")
                        .font(.custom(FontStyles.light, size: FontStyles.small))
                        .foregroundColor(Color.grey100)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                }
            }
            VStack(spacing: 16) {
                
                SegmentedControl(selectedSport: $selectedSport, availableSports: authViewModel.availableSports)
                FreeLeagueList(leagues: authViewModel.leaguesBySport[selectedSport] ?? [], selectedLeagueKey: $viewModel.selectedLeagueKey)
                    .onAppear {
                        authViewModel.fetchAvailableLeagues {
                            self.selectedSport = authViewModel.availableSports.first ?? "soccer"
                        }
                    }
            }
        }
        .padding(.top, 32)
        Spacer()
        
        VStack(spacing: 16) {
            ActionButton(
                text: "Finaliser l'inscription",
                action: {
                    Task {
                        await viewModel.completeSignUp(authViewModel: authViewModel)
                    }
                },
                isEnabled: viewModel.selectedLeagueKey != nil
            )
            
            HStack {
                Button(action: {
                    viewModel.previousStep()
                }) {
                    Text("Retour")
                        .font(.custom(FontStyles.medium, size: FontStyles.normal))
                        .foregroundColor(Color.grey100)
                }
            }
            .frame(height: 24)
        }
    }
}
