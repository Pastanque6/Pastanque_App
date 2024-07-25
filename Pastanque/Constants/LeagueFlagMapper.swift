import Foundation

struct LeagueFlagMapper {
    static let flagForCountry: [String: String] = [
        "France": "france",
        "Spain": "spain",
        "Germany": "germany",
        "England": "england",
        "USA": "usa",
        "Italy": "italy",
        "Europe": "europe"
    ]
    
    static func flagName(for country: String) -> String {
        return flagForCountry[country] ?? "worldwide"
    }
}
