import SwiftUI

struct MatchesView: View {
    @EnvironmentObject var matchesViewModel: MatchesViewModel

    var body: some View {
        VStack(spacing: 12) {
            MatchFilterList(viewModel: matchesViewModel)
            MatchesList()
        }
    }
}
