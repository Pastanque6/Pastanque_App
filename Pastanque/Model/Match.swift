import Foundation
import FirebaseFirestoreSwift

struct Match: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    var sportKey: String
    var leagueName: String
    var country: String
    var sport: String
    var homeTeam: String
    var awayTeam: String
    var matchTime: Date
    var odds: Odds

    enum CodingKeys: String, CodingKey {
        case sportKey = "sport_key"
        case leagueName = "league_name"
        case country
        case sport
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case matchTime = "commence_time"
        case odds
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        sportKey = try container.decode(String.self, forKey: .sportKey)
        leagueName = try container.decode(String.self, forKey: .leagueName)
        country = try container.decode(String.self, forKey: .country)
        sport = try container.decode(String.self, forKey: .sport)
        homeTeam = try container.decode(String.self, forKey: .homeTeam)
        awayTeam = try container.decode(String.self, forKey: .awayTeam)
        matchTime = try container.decode(DateValue.self, forKey: .matchTime).date
        odds = try container.decodeIfPresent(Odds.self, forKey: .odds) ?? Odds(homeTeam: nil, awayTeam: nil, draw: nil)
    }

    static func == (lhs: Match, rhs: Match) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Odds: Codable, Equatable {
    struct OddDetail: Codable, Equatable {
        var id: String
        var value: Double
        var label: String
    }
    
    var homeTeam: OddDetail?
    var awayTeam: OddDetail?
    var draw: OddDetail?

    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case draw
    }
}

struct DateValue: Codable {
    let date: Date

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format")
        }
        
        self.date = date
    }
}
