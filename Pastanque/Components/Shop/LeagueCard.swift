import SwiftUI

struct LeagueCard: View {
    var league: League
    var isUnlocked: Bool
    var onPurchase: (() -> Void)?

    var body: some View {
        if isUnlocked {
            content
        } else {
            Button(action: {
                onPurchase?()
            }) {
                content
            }
        }
    }
    
    @ViewBuilder
    var content: some View {
        let flagName = LeagueFlagMapper.flagName(for: league.country)
        
        HStack(spacing: 16) {
            Image(flagName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .opacity(isUnlocked ? 0.5 : 1)
            
            Text(league.name)
                .font(.custom(FontStyles.light, size: FontStyles.normal))
                .foregroundColor(isUnlocked ? Color.customWhite.opacity(0.5) : Color.customWhite)
            
            Spacer()
            
            if isUnlocked {
                Text("Débloqué")
                    .font(.custom(FontStyles.light, size: FontStyles.small))
                    .foregroundColor(.customWhite.opacity(0.5))
            } else {
                CreditsValue(valueText: "\(league.cost)", imageName: "PSTGems")
            }
        }
        .padding(.horizontal)
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .background(isUnlocked ? Color.grey400.opacity(0.5) : Color.grey400)
        .cornerRadius(8)
    }
}
