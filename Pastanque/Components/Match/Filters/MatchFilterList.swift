import SwiftUI

struct MatchFilterList: View {
    @ObservedObject var viewModel: MatchesViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(viewModel.leagues, id: \.self) { league in
                    MatchFilter(league: league, isSelected: viewModel.selectedLeague == league) {
                        viewModel.selectedLeague = viewModel.selectedLeague == league ? nil : league
                    }
                }
            }
        }
    }
}
