import SwiftUI

struct MatchFilterList: View {
    @ObservedObject var viewModel: MatchesViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(sortedLeagues(), id: \.self) { league in
                    MatchFilter(league: league, isSelected: viewModel.selectedLeague == league) {
                        viewModel.selectedLeague = viewModel.selectedLeague == league ? nil : league
                    }
                }
            }
        }
    }
    
    // Méthode pour trier les ligues par ordre d'importance
    private func sortedLeagues() -> [String] {
        let leagues = viewModel.leagues
        return leagues.sorted { lhs, rhs in
            let lhsIndex = LeagueOrder.order.firstIndex(of: lhs) ?? Int.max
            let rhsIndex = LeagueOrder.order.firstIndex(of: rhs) ?? Int.max
            return lhsIndex < rhsIndex
        }
    }
}
