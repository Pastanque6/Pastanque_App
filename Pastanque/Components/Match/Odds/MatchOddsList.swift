import SwiftUI

struct MatchOddsList: View {
    @EnvironmentObject var viewModel : MatchesViewModel
    var matchId: String
    let odds: Odds
    let homeTeam: String
    let awayTeam: String
    
    var organizedOddsData: [Odds.OddDetail] {
        var orderedOdds: [Odds.OddDetail] = []
        
        if let homeOdd = odds.homeTeam {
            orderedOdds.append(homeOdd)
        }
        
        if let drawOdd = odds.draw {
            orderedOdds.append(drawOdd)
        }
        
        if let awayOdd = odds.awayTeam {
            orderedOdds.append(awayOdd)
        }
        
        return orderedOdds
    }
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(organizedOddsData, id: \.id) { odd in
                MatchOdds(
                    team: odd.label,
                    odds: odd.value,
                    oddId: odd.id,
                    isSelected: viewModel.selectedOddsForMatch[matchId] == odd.id,
                    onSelect: {
                        viewModel.toggleSelectedOdd(forMatch: matchId, withOddId: odd.id)
                    }
                )
            }
        }
    }
}

