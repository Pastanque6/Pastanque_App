import SwiftUI

struct MatchOddsList: View {
    @EnvironmentObject var viewModel: MatchesViewModel
    var match: Match
    
    var organizedOddsData: [(id: String, value: Double, team: String)] {
        var orderedOdds: [(id: String, value: Double, team: String)] = []
        
        if let homeOdd = match.odds.homeTeam {
            orderedOdds.append((id: "home", value: homeOdd, team: match.homeTeam))
        }
        
        if let drawOdd = match.odds.draw {
            orderedOdds.append((id: "draw", value: drawOdd, team: "Match nul"))
        }
        
        if let awayOdd = match.odds.awayTeam {
            orderedOdds.append((id: "away", value: awayOdd, team: match.awayTeam))
        }
        
        return orderedOdds
    }
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(organizedOddsData, id: \.id) { odd in
                MatchOdds(
                    team: odd.team,
                    odds: odd.value,
                    oddId: odd.id,
                    isSelected: viewModel.selectedOddsForMatch[match.id ?? ""] == odd.id,
                    onSelect: {
                        viewModel.toggleSelectedOdd(forMatch: match.id ?? "", withOddId: odd.id)
                    }
                )
            }
        }
    }
}
