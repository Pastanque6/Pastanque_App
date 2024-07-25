import SwiftUI

struct TabBarItem: View {
    let title: String
    let iconNameOn: String
    let iconNameOff: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Image(isSelected ? iconNameOn : iconNameOff)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text(title)
            }
            .foregroundColor(isSelected ? .customPrimary : .grey100)
            .font(.custom(FontStyles.light, size: FontStyles.xsmall))
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
}
