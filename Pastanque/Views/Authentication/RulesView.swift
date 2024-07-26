import SwiftUI

struct RulesView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    @State private var isSelected: Bool = false
    
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 8) {
                HStack {
                    Text("Règles")
                        .font(.custom(FontStyles.medium, size: FontStyles.big))
                        .foregroundColor(Color.customWhite)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                }
                VStack(spacing: 4) {
                    Text("Quelques infos avant de devenir THE GOAT.")
                        .font(.custom(FontStyles.light, size: FontStyles.small))
                        .foregroundColor(Color.grey100)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    Text("Tu pourras retrouver toutes les règles dans ton profil.")
                        .font(.custom(FontStyles.light, size: FontStyles.small))
                        .foregroundColor(Color.grey100)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                }
            }
            
            VStack(spacing: 16) {
                Group {
                    Text("🎯 Choisis tes cotes sur les matchs de ton choix. Chaque pari te donne de l’expérience pour accéder à de nouveaux défis.")
                        .font(.custom(FontStyles.light, size: FontStyles.normal))
                        .foregroundColor(Color.customWhite)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Divider()
                                .background(Color.grey200)
                        }
                        .frame(height: 1)
                        .padding(.horizontal, 32)
                        Spacer()
                    }
                    
                    
                    Text("🫡 Si tu tombes à 0, c'est l'heure de la remontada. Tu peux toujours parier avec une mise max de 5 et un pari à la fois !")
                        .font(.custom(FontStyles.light, size: FontStyles.normal))
                        .foregroundColor(Color.customWhite)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Divider()
                                .background(Color.grey200)
                        }
                        .frame(height: 2)
                        .padding(.horizontal, 32)
                        Spacer()
                    }
                    
                    Text("🤑 Les gems permettent de débloquer pas mal de choses. Et la bonne nouvelle c’est que tu peux transformer tes gains en gems !")
                        .font(.custom(FontStyles.light, size: FontStyles.normal))
                        .foregroundColor(Color.customWhite)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Divider()
                                .background(Color.grey200)
                        }
                        .frame(height: 2)
                        .padding(.horizontal, 32)
                        Spacer()
                    }
                }
            }

            Button(action: {
                self.isSelected.toggle()
                viewModel.acceptedRules = self.isSelected
            }) {
                HStack {
                    HStack(spacing: 12) {
                        Image(isSelected ? "Selected" : "Unselected")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("J'accepte les règles du jeu")
                            .font(.custom(FontStyles.light, size: FontStyles.small))
                            .foregroundColor(Color.customWhite)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            VStack(spacing: 16) {
                ActionButton(
                    text: "Suivant",
                    action: {
                        Task {
                            viewModel.nextStep()
                        }
                    },
                    isEnabled: isSelected
                )
                HStack {
                    Button(action: {
                        viewModel.previousStep()
                        print("Back button tapped")
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
}
