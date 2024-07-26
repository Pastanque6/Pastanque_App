import SwiftUI

struct SportFilter: View {
    let sportName: String
    var isSelected: Bool
    var onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            Text(sportName)
                .font(.custom(FontStyles.medium, size: FontStyles.normal))
                .foregroundColor(isSelected ? Color.customWhite : Color.grey100)
                .padding(.bottom, 8)
        }
        .frame(height: 32)
        .padding(.horizontal, 4)
        .overlay(
            Rectangle()
                .frame(height: 2)
                .foregroundColor(isSelected ? Color.customPrimary : .clear)
                .padding(.horizontal, 4),
            alignment: .bottom
        )
    }
}
