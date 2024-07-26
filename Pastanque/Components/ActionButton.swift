import SwiftUI

struct ActionButton: View {
    var text: String
    var action: () -> Void
    var isEnabled: Bool
    var imageName: String? = nil
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .font(.custom(FontStyles.medium, size: FontStyles.normal))
                    .foregroundColor(Color.customWhite)
                
                if let imageName = imageName, !imageName.isEmpty {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            }
            .frame(height: 45)
            .frame(maxWidth: .infinity)
            .background(isEnabled ? Color.customPrimary : Color.customPrimary.opacity(0.5))
            .cornerRadius(8)
        }
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1.0 : 0.5)
    }
}
