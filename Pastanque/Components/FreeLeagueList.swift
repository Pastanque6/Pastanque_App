import SwiftUI

struct FreeLeagueList: View {
    var leagues: [League]
    @Binding var selectedLeagueKey: String?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(sortedLeagues()) { league in
                    FreeLeague(league: league, selectedLeagueKey: $selectedLeagueKey)
                }
            }
        }
    }
    
    private func sortedLeagues() -> [League] {
        return leagues.sorted { lhs, rhs in
            
            let lhsIndex = LeagueOrder.order.firstIndex(of: lhs.name) ?? Int.max
            let rhsIndex = LeagueOrder.order.firstIndex(of: rhs.name) ?? Int.max
            return lhsIndex < rhsIndex
            
        }
    }
}
