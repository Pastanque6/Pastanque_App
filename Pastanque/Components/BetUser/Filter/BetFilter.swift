import SwiftUI

struct BetFilter: View {
    let title: String
    var isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            Text(title)
                .font(.custom(FontStyles.medium, size: FontStyles.normal))
                .foregroundColor(isSelected ? Color.customWhite : Color.grey100)
                .frame(maxHeight: .infinity)
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 32)
        .padding(.horizontal, 8)
        .overlay(
            Rectangle()
                .frame(height: 2)
                .foregroundColor(isSelected ? Color.customPrimary : .clear)
                .padding(.horizontal, 4),
            alignment: .bottom
        )
    }
}
