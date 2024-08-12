import SwiftUI

struct LeagueCardList: View {
    var leagues: [League]
    var unlockedLeagues: [String]
    var onPurchase: (String) -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(sortedLeagues()) { league in
                    LeagueCard(league: league, isUnlocked: unlockedLeagues.contains(league.id)) {
                        onPurchase(league.id)
                    }
                }
            }
        }
    }
    
    private func sortedLeagues() -> [League] {
        return leagues.sorted { lhs, rhs in
            let lhsUnlocked = unlockedLeagues.contains(lhs.id)
            let rhsUnlocked = unlockedLeagues.contains(rhs.id)
            
            if lhsUnlocked == rhsUnlocked {
                let lhsIndex = LeagueOrder.order.firstIndex(of: lhs.name) ?? Int.max
                let rhsIndex = LeagueOrder.order.firstIndex(of: rhs.name) ?? Int.max
                return lhsIndex < rhsIndex
            } else {
                return !lhsUnlocked
            }
        }
    }
}
