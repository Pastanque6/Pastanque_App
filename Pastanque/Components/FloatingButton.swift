import SwiftUI

struct FloatingButton: View {
    @EnvironmentObject var viewModel: MatchesViewModel
    @EnvironmentObject var authManager: AuthViewModel
    @State private var showModal = false
    
    private func formatOddsProduct(_ oddsProduct: Double) -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = " "
        formatter.groupingSize = 3
        
        if oddsProduct >= 1000 {
            formatter.maximumFractionDigits = 0
            return formatter.string(from: NSNumber(value: floor(oddsProduct))) ?? "\(oddsProduct)"
        } else if floor(oddsProduct) == oddsProduct {
            formatter.maximumFractionDigits = 0
        } else {
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
        }
        
        return formatter.string(from: NSNumber(value: oddsProduct)) ?? "\(oddsProduct)"
    }
    
    var body: some View {
        if viewModel.oddsProduct > 1 {
            Button(action: {
                showModal = true
            }) {
                Text(formatOddsProduct(viewModel.oddsProduct))
                    .font(.custom(FontStyles.medium, size: FontStyles.large))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal, 4)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 50)
                    .background(Color.customPrimary)
                    .cornerRadius(20)
            }
            .frame(width: 70, height: 70)
            .animation(.default, value: viewModel.oddsProduct)
            .transition(.scale)
            
            .sheet(isPresented: $showModal) {
                BetModalView(isPresented: $showModal, credits: authManager.user?.credits ?? 0.0)
                    .environmentObject(viewModel)
                    .presentationDragIndicator(.visible)
                    .presentationBackground(Color.grey600)
                    .padding(.top, 8)
                    .presentationCornerRadius(8)
            }
        }
    }
}
