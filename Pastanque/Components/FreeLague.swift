import SwiftUI

struct FreeLeague: View {
    var league: League
    @Binding var selectedLeagueKey: String?
    
    var body: some View {
        Button(action: {
            selectedLeagueKey = selectedLeagueKey == league.id ? nil : league.id
        }) {
            HStack(spacing: 12) {
                Image(LeagueFlagMapper.flagName(for: league.country))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text(league.name)
                    .font(.custom(FontStyles.medium, size: FontStyles.normal))
                    .foregroundColor(Color.customWhite)
                
                Spacer()
                
                Image(league.id == selectedLeagueKey ? "Selected" : "Unselected")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(league.id == selectedLeagueKey ? .green : .gray)
            }
            .padding(.horizontal, 12)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.grey400)
            .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
