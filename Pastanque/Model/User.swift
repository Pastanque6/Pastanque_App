import Foundation

struct User: Identifiable, Codable {
    var id: String
    var username: String
    var phoneNumber: String
    var credits: Double
    var gems: Int
    var avatar: String
    var unlockedLeagues: [String]
}

enum CurrencyType {
    case credits
    case gems
}
