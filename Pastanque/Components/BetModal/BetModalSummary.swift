import SwiftUI

struct BetModalSummary: View {
    @EnvironmentObject var viewModel: MatchesViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var wager: String = "10"
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var totalOdds: Double {
        viewModel.oddsProduct
    }

    var potentialWinnings: Double {
        (Double(wager) ?? 0.0) * totalOdds
    }

    private func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }

    private func placeBet() {
        guard let wagerAmount = Double(wager), wagerAmount > 0 else {
            alertMessage = "Veuillez entrer une mise valide."
            showAlert = true
            return
        }

        let individualBets = viewModel.selectedMatchesAndOdds.map { (match, odd) -> UserBet in
            return UserBet(
                id: UUID().uuidString,
                match: match.id ?? "",
                homeTeam: match.homeTeam,
                awayTeam: match.awayTeam,
                matchDate: match.matchTime,
                userBet: odd.label,
                selectedOdds: odd.value,
                betResult: "pending",
                leagueName: match.leagueName,
                sportType: match.sport,
                country: match.country
            )
        }

        authViewModel.placeBet(wager: wagerAmount, potentialWinnings: potentialWinnings, individualBets: individualBets) { success, message in
            if success {
                alertMessage = "Pari placé avec succès !"
                showAlert = true
                viewModel.clearAllSelectedOdds()
            } else {
                alertMessage = message ?? "Erreur inconnue."
                showAlert = true
            }
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Mise:")
                    .font(.headline)
                    .foregroundColor(.customWhite)
                TextField("Mise", text: $wager)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(CustomTextFieldStyle(backgroundColor: Color.grey500))
                    .padding(.leading, 8)
            }
            .padding(.horizontal)

            HStack {
                Text("Cote totale:")
                    .font(.headline)
                    .foregroundColor(.customWhite)
                Spacer()
                Text(formatNumber(totalOdds))
                    .font(.headline)
                    .foregroundColor(.customPrimary)
            }
            .padding(.horizontal)

            HStack {
                Text("Gains potentiels:")
                    .font(.headline)
                    .foregroundColor(.customWhite)
                Spacer()
                Text(formatNumber(potentialWinnings))
                    .font(.headline)
                    .foregroundColor(.customPrimary)
            }
            .padding(.horizontal)

            Button(action: placeBet) {
                Text("Parier")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.customPrimary)
                    .cornerRadius(8)
            }
            .padding(.top, 16)
        }
        .padding()
        .background(Color.grey600)
        .cornerRadius(8)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Message"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}
