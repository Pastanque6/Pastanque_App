import SwiftUI

struct BetModalView: View {
    @Binding var isPresented: Bool
    @EnvironmentObject var viewModel: MatchesViewModel
    var credits: Double

    var body: some View {
        VStack {
            BetModalHeader(isPresented: $isPresented, credits: credits )

            BetModalList()
                .environmentObject(viewModel)

            Spacer()
            
            BetModalSummary()
                .environmentObject(viewModel)
        }
        .padding(12)
    }
}
