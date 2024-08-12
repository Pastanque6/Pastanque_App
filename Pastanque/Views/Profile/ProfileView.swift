import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var isPresented: Bool
    @State private var showingSettings = false
    @State private var selectedAvatar: String = "avatar1"
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    isPresented = false
                }) {
                    Image("Cross")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                
                Spacer()
                
                Text("Profil")
                    .font(.custom(FontStyles.medium, size: FontStyles.large))
                    .foregroundColor(Color.customWhite)
                
                Spacer()
                
                Button(action: {
                    showingSettings = true
                }) {
                    Image("Settings")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
    
            }
            HStack(spacing: 32) {
                VStack(spacing: 8) {
                    Image(authViewModel.user?.avatar ?? "avatar1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 96, height: 96)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.customPrimary, lineWidth: 1)
                        )
                    
                    Text("\(authViewModel.user?.username ?? "User")!")
                        .font(.custom(FontStyles.medium, size: FontStyles.normal))
                        .foregroundColor(Color.customPrimary)
                }
                Spacer()
                VStack {
                    Text("Niveau 45")
                        .font(.custom(FontStyles.medium, size: FontStyles.normal))
                        .foregroundColor(Color.customPrimary)
                }
            }
            .padding(.horizontal, 24)
            
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(12)
        .background(Color.grey600)
        .sheet(isPresented: $showingSettings) {
            SettingsView(isPresented: $showingSettings, selectedAvatar: $selectedAvatar)
                .environmentObject(authViewModel)
        }
    }
}
