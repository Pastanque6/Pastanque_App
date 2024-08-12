import Foundation

struct League: Identifiable {
    let id: String
    let name: String
    let sport: String
    let country: String
    let cost: Int
    
    init(id: String, name: String, sport: String, country: String, cost: Int) {
        self.id = id
        self.name = name
        self.sport = sport
        self.country = country
        self.cost = cost
    }
}

