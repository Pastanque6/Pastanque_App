import SwiftUI

struct BetModalCard: View {
    let match: Match
    let oddLabel: String
    let oddValue: Double
    var onRemove: () -> Void
    
    var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    HStack {
                        Text(match.homeTeam)
                        Text("-")
                        Text(match.awayTeam)
                    }
                    .font(.custom(FontStyles.medium, size: FontStyles.small))
                    .foregroundColor(Color.grey100)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: onRemove) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 16))
                                .foregroundColor(Color.grey100)
                        }
                    }
                }
                
                HStack {
                    Text("\(oddLabel)")
                        .font(.custom(FontStyles.light, size: FontStyles.normal))
                        .foregroundColor(Color.customWhite)
                    
                    Spacer()
                    
                    Text("\(NumberFormatter.formatNumber(oddValue))")
                        .font(.custom(FontStyles.medium, size: FontStyles.large))
                        .foregroundColor(Color.customPrimary)
                }
            }
            .padding()
            .background(Color.grey500)
            .cornerRadius(8)
    }
}
