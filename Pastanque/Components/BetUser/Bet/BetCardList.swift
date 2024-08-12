import SwiftUI

struct BetCardList: View {
    let bets: [Bet]

    var body: some View {
        if bets.isEmpty {
            VStack(spacing: 20) {
                Text("Aucun pari")
                    .foregroundColor(.gray)
            }
        } else {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(bets) { bet in
                        BetCard(bet: bet)
                    }
                }
            }
        }
    }
}
