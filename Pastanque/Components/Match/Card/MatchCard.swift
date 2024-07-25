import SwiftUI

struct MatchCard: View {
    var match: Match

    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 12) {
            MatchLeague(leagueName: match.leagueName, country: match.country)
            
            MatchTeams(homeTeam: match.homeTeam, awayTeam: match.awayTeam)
            
            MatchStartTime(commenceTime: match.matchTime)
            }
            MatchOddsList(match: match)
        }
        .padding(8)
        .background(Color.grey500)
        .cornerRadius(8)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
