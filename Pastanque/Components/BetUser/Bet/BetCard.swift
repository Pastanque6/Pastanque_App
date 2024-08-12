import SwiftUI

struct BetCard: View {
    let bet: Bet
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(bet.individualBets) { individualBet in
                IndividualBet(individualBet: individualBet)
            }
            SummaryBet(bet: bet)
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .padding(.horizontal, 8)
        .background(Color.grey600)
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
