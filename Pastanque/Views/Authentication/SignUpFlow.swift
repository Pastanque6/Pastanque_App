import SwiftUI

struct SignUpFlow: View {
    @StateObject var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.currentStep {
            case 1:
                UsernamePhoneView()
                    .environmentObject(viewModel)
            case 2:
                RulesView()
                    .environmentObject(viewModel)
            case 3:
                LeagueSelectionView()
                    .environmentObject(viewModel)
            default:
                EmptyView()
            }
        }
        .frame(maxHeight: .infinity)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 12)
        .background(Color.customBlack)
    }
}
