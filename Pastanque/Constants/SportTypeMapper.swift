import Foundation

struct SportTypeMapper {
    // Fonction qui retourne le nom de l'icône pour un type de sport donné
    static func iconName(for sportType: String) -> String {
        // Retourne l'icône correspondante ou une icône par défaut
        return sportType.lowercased()
    }
}
