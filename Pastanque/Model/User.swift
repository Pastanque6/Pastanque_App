import Foundation

struct User: Identifiable, Codable {
    var id: String
    var username: String
    var phoneNumber: String
    var unlockedLeagues: [String]
}
