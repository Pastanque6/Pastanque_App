import SwiftUI

struct CreditsValue: View {
    let valueText: String
    let imageName: String
    
    var body: some View {
        HStack(spacing: 8) {
            Text(valueText)
                .foregroundColor(.customWhite)
                .font(.custom(FontStyles.medium, size: FontStyles.normal))
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
        }
        .padding(4)
    }
}
