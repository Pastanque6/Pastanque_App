import SwiftUI

struct SummaryBet: View {
    let bet: Bet
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Mise")
                    .font(.custom(FontStyles.light, size: FontStyles.small))
                    .foregroundColor(Color.grey100)
                Spacer()
                Text("\(NumberFormatter.formatNumber(bet.wager))")
                    .font(.custom(FontStyles.light, size: FontStyles.small))
                    .foregroundColor(Color.grey100)
            }
            HStack {
                Text("Gains potentiels")
                    .font(.custom(FontStyles.light, size: FontStyles.small))
                    .foregroundColor(Color.customWhite)
                Spacer()
                Text("\(NumberFormatter.formatNumber(bet.potentialWinnings))")
                    .font(.custom(FontStyles.light, size: FontStyles.small))
                    .foregroundColor(bet.betStatus == "won" ? .green : (bet.betStatus == "lost" ? .red : Color.customWhite))
            }
        }
    }
}
