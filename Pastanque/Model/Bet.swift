import Foundation

struct Bet: Identifiable, Codable {
    let id: String
    let userId: String
    let wager: Double
    let potentialWinnings: Double
    let betStatus: String
    let winningsCredited: Bool
    let individualBets: [UserBet]
    let createdAt: Date
    let netWinnings: Double
    
    var dictionary: [String: Any] {
        return [
            "id": id,
            "userId": userId,
            "wager": wager,
            "potentialWinnings": potentialWinnings,
            "betStatus": betStatus,
            "winningsCredited": winningsCredited,
            "individualBets": individualBets.map { $0.dictionary },
            "createdAt": createdAt,
            "netWinnings": netWinnings
        ]
    }
}

struct UserBet: Identifiable, Codable {
    let id: String
    let match: String
    let homeTeam: String
    let awayTeam: String
    let matchDate: Date
    let userBet: String
    let selectedOdds: Double
    let betResult: String
    let leagueName: String
    let sportType: String
    let country: String
    
    var dictionary: [String: Any] {
        return [
            "id": id,
            "match": match,
            "homeTeam": homeTeam,
            "awayTeam": awayTeam,
            "matchDate": matchDate,
            "userBet": userBet,
            "selectedOdds": selectedOdds,
            "betResult": betResult,
            "leagueName": leagueName,
            "sportType": sportType,
            "country": country
        ]
    }
}
