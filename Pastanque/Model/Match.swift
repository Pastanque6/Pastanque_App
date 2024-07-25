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
    var homeTeam: Double?
    var awayTeam: Double?
    var draw: Double?

    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case draw
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        homeTeam = try? container.decodeIfPresent(Double.self, forKey: .homeTeam)
        awayTeam = try? container.decodeIfPresent(Double.self, forKey: .awayTeam)
        draw = try? container.decodeIfPresent(Double.self, forKey: .draw)
        
        if homeTeam == nil, let homeTeamString = try? container.decodeIfPresent(String.self, forKey: .homeTeam) {
            homeTeam = Double(homeTeamString)
        }
        
        if awayTeam == nil, let awayTeamString = try? container.decodeIfPresent(String.self, forKey: .awayTeam) {
            awayTeam = Double(awayTeamString)
        }
        
        if draw == nil, let drawString = try? container.decodeIfPresent(String.self, forKey: .draw) {
            draw = Double(drawString)
        }
    }

    init(homeTeam: Double?, awayTeam: Double?, draw: Double?) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.draw = draw
    }

    static func == (lhs: Odds, rhs: Odds) -> Bool {
        return lhs.homeTeam == rhs.homeTeam &&
               lhs.awayTeam == rhs.awayTeam &&
               lhs.draw == rhs.draw
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
