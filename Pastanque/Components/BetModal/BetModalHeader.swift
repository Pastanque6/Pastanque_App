import SwiftUI

struct BetModalHeader: View {
    @EnvironmentObject var viewModel: MatchesViewModel
    @Binding var isPresented: Bool
    var credits : Double
    
    var body: some View {
        HStack {
            Button(action: {
                isPresented = false
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 20))
                    .foregroundColor(Color.grey100)
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Text("\(NumberFormatter.formatNumber(credits))")
                    .font(.custom(FontStyles.medium, size: FontStyles.normal))
                    .foregroundColor(.customPrimary)
                Image("PSTCoins")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            
            Spacer()
            
            Button(action: {
                viewModel.clearAllSelectedOdds()
                isPresented = false
            }) {
                Image(systemName: "trash")
                    .font(.system(size: 20))
                    .foregroundColor(Color.grey100)
            }
        }
        .multilineTextAlignment(.center)
    }
}
