import SwiftUI

struct MatchesView: View {
    @ObservedObject var viewModel: MatchesViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            MatchFilterList(viewModel: viewModel)
            MatchesList()
                .environmentObject(viewModel)
        }
        .padding(.top, 4)
        .overlay(
            FloatingButton()
                .environmentObject(viewModel)
                .padding(),
            alignment: .bottomTrailing
        )
    }
}
