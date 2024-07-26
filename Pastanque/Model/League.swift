import Foundation

struct League: Identifiable {
    let id: String
    let name: String
    let sport: String
    let country: String
    
    init(id: String, name: String, sport: String, country: String) {
        self.id = id
        self.name = name
        self.sport = sport
        self.country = country
    }
}
