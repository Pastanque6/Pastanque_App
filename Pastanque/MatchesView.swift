import SwiftUI

struct MatchesView: View {
    @EnvironmentObject var matchesViewModel: MatchesViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Matches")
                .font(.title)
                .padding(.horizontal)
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(matchesViewModel.matches) { match in
                        VStack(alignment: .leading) {
                            Text("\(match.homeTeam) vs \(match.awayTeam)")
                                .font(.custom(FontStyles.medium, size: FontStyles.normal))
                            Text("League: \(match.leagueName)")
                                .font(.custom(FontStyles.medium, size: FontStyles.normal))
                            Text("Date: \(match.commenceTime)")
                                .font(.headline)
                            
                            VStack(alignment: .leading) {
                                if let homeOdds = match.odds.homeTeam {
                                    Text("Odds for \(match.homeTeam): \(oddsFormatter.string(from: NSNumber(value: homeOdds)) ?? "\(homeOdds)")")
                                }
                                if let awayOdds = match.odds.awayTeam {
                                    Text("Odds for \(match.awayTeam): \(oddsFormatter.string(from: NSNumber(value: awayOdds)) ?? "\(awayOdds)")")
                                }
                                if let drawOdds = match.odds.draw {
                                    Text("Odds for Draw: \(oddsFormatter.string(from: NSNumber(value: drawOdds)) ?? "\(drawOdds)")")
                                }
                            }
                            .font(.caption)
                            .padding(.top, 8)
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(8)
                        .shadow(radius: 2)
                        .padding(.horizontal)
                        .padding(.vertical, 4)
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
