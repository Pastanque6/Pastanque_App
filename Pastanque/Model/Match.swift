import Foundation
import FirebaseFirestoreSwift

struct Match: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    var sportKey: String
    var leagueName: String
    var homeTeam: String
    var awayTeam: String
    var commenceTime: String
    var odds: Odds

    enum CodingKeys: String, CodingKey {
        case id
        case sportKey = "sport_key"
        case leagueName = "league_name"
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case commenceTime = "commence_time"
        case odds
    }

    // Implémentez Equatable
    static func == (lhs: Match, rhs: Match) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Odds: Codable, Equatable {
    var homeTeam: Double?
    var awayTeam: Double?
    var draw: Double?

    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case draw
    }

    // Implémentez Equatable pour Odds aussi
    static func == (lhs: Odds, rhs: Odds) -> Bool {
        return lhs.homeTeam == rhs.homeTeam &&
               lhs.awayTeam == rhs.awayTeam &&
               lhs.draw == rhs.draw
    }
}
