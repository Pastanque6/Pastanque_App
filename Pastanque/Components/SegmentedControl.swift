import SwiftUI

struct SegmentedControl: View {
    @Binding var selectedSport: String
    let availableSports: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(availableSports, id: \.self) { sport in
                    SportFilter(sportName: SportsConfig.sportsLabels[sport] ?? sport, isSelected: sport == selectedSport) {
                        selectedSport = sport
                    }
                }
            }
        }
    }
}
