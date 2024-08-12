import SwiftUI

struct BetFilterList: View {
    @Binding var selectedFilter: BetFilterType
    
    var body: some View {
        HStack {
            BetFilter(title: BetFilterType.inProgress.rawValue, isSelected: selectedFilter == .inProgress) {
                selectedFilter = .inProgress
            }
            BetFilter(title: BetFilterType.won.rawValue, isSelected: selectedFilter == .won) {
                selectedFilter = .won
            }
            BetFilter(title: BetFilterType.over.rawValue, isSelected: selectedFilter == .over) {
                selectedFilter = .over
            }
        }
    }
}

enum BetFilterType: String {
    case inProgress = "En cours"
    case won = "Gagnés"
    case over = "Terminés"
}
