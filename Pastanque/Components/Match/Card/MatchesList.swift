import SwiftUI

struct MatchesList: View {
    @EnvironmentObject var matchesViewModel: MatchesViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(matchesViewModel.filteredMatches) { match in
                        MatchCard(match: match)
                    }
                }
                .padding(.vertical)
            }
        }
        .onAppear {
            if let unlockedLeagues = authViewModel.user?.unlockedLeagues {
                matchesViewModel.fetchMatches(for: unlockedLeagues)
            }
        }
        .onChange(of: matchesViewModel.matches) { oldMatches, newMatches in
            print("Matches updated: \(newMatches.count) matches loaded.")
        }
    }
}
