import SwiftUI

struct MatchOdds: View {
    let team: String
    let odds: Double
    let oddId: String
    var isSelected: Bool
    var onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            VStack(spacing: 0) {
                VStack {
                    Text(team)
                        .font(.custom(FontStyles.light, size: FontStyles.tiny))
                        .foregroundColor(isSelected ? Color.grey600 : Color.grey100)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .frame(maxHeight: .infinity)
                        .multilineTextAlignment(.center)
                }
                .frame(height: 15)
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("\(NumberFormatter.formatNumber(odds))")
                        .font(.custom(FontStyles.medium, size: FontStyles.large))
                        .foregroundColor(isSelected ? Color.grey600 : Color.customWhite)
                        .frame(maxHeight: .infinity)
                        .multilineTextAlignment(.center)
                }
                .frame(height: 20)
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 44)
        .padding(.horizontal, 8)
        .padding(.vertical, 2)
        .background(isSelected ? Color.customPrimary : Color.grey300)
        .cornerRadius(8)
        .frame(maxWidth: .infinity)
    }
}
