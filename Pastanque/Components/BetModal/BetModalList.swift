import SwiftUI

struct BetModalList: View {
    @EnvironmentObject var viewModel: MatchesViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(viewModel.selectedMatchesAndOdds, id: \.match.id) { item in
                    BetModalCard(
                        match: item.match,
                        oddLabel: item.odd.label,
                        oddValue: item.odd.value,
                        onRemove: {
                            viewModel.toggleSelectedOdd(forMatch: item.match.id ?? "", withOddId: item.odd.id)
                        }
                    )
                }
            }
            .padding(.top, 12)
        }
    }
}
