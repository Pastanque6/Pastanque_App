import SwiftUI

struct FreeLeagueList: View {
    var leagues: [League]
    @Binding var selectedLeagueKey: String?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(leagues) { league in
                    FreeLeague(league: league, selectedLeagueKey: $selectedLeagueKey)
                }
            }
        }
    }
}
