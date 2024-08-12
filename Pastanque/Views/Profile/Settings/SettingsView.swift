import SwiftUI

struct SettingsView: View {
    @State private var currentView: String? = nil
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var isPresented: Bool
    @Binding var selectedAvatar: String
    
    var body: some View {
        VStack {
            switch currentView {
            case "Règles":
                RulesDetailedView(backAction: { self.currentView = nil })
            case "Avatar":
                AvatarView(selectedAvatar: $selectedAvatar, backAction: { self.currentView = nil })
            default:
                VStack {
                    
                    HStack {
                        Button(action: {
                            isPresented = false
                        }) {
                            Image(systemName: "chevron.left")
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.customWhite)
                        }
                        
                        Spacer()
                        
                        Text("Paramètres")
                            .font(.custom(FontStyles.medium, size: FontStyles.normal))
                            .foregroundColor(Color.customWhite)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.left")
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.clear)
                            .disabled(true)
                    }
                    .padding(.bottom, 16)
                    
                    
                    SettingsCardList(navigateTo: { view in
                        self.currentView = view
                    })
                    
                    HStack {
                        Button(action: {
                            authViewModel.logout()
                        }) {
                            Text("Déconnexion")
                                .font(.custom(FontStyles.medium, size: FontStyles.normal))
                                .foregroundColor(Color.grey100)
                        }
                    }
                    .frame(height: 24)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(12)
        .background(Color.grey600)
        .onAppear {
            self.selectedAvatar = authViewModel.user?.avatar ?? "avatar1"
        }
        .onChange(of: selectedAvatar) { newAvatar in
            authViewModel.updateAvatar(avatar: newAvatar)
        }
    }
}
