import SwiftUI

struct MatchCard: View {
    @EnvironmentObject var viewModel: MatchesViewModel
    var match: Match
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 12) {
                MatchLeague(leagueName: match.leagueName, country: match.country)
                
                MatchTeams(homeTeam: match.homeTeam, awayTeam: match.awayTeam)
                
                MatchStartTime(commenceTime: match.matchTime)
            }
            MatchOddsList(
                matchId: match.id ?? "",
                odds: match.odds,
                homeTeam: match.homeTeam,
                awayTeam: match.awayTeam
            )        }
        .padding(8)
        .background(Color.grey500)
        .cornerRadius(8)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
