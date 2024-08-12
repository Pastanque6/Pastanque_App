import SwiftUI

struct SettingsCardList: View {
    let navigateTo: (String) -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Button(action: { navigateTo("Règles") }) {
                SettingsCard(title: "Règles")
            }
            Button(action: { navigateTo("Avatar") }) {
                SettingsCard(title: "Avatar")
            }
            Spacer()
        }
    }
}

