import SwiftUI

struct SettingsCard: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom(FontStyles.light, size: FontStyles.normal))
                .foregroundColor(Color.customWhite)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color.customWhite)
                .scaledToFit()
                .frame(width: 20, height: 20)
        }
        .padding(.horizontal)
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .background(Color.grey400)
        .cornerRadius(8)
    }
}
