import SwiftUI

struct MatchFilter: View {
    let league: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
                Text(league)
                    .font(.custom(FontStyles.medium, size: FontStyles.small))
                    .foregroundColor(isSelected ? Color.grey600 : Color.customWhite)
                    .frame(maxHeight: .infinity)
                    .multilineTextAlignment(.center)
        }
        .frame(height: 32)
        .padding(.vertical, 2)
        .padding(.horizontal, 8)
        .background(isSelected ? Color.customPrimary : Color.grey300)
        .cornerRadius(8)
    }
}

