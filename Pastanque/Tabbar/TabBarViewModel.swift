import Foundation
import SwiftUI

class TabBarViewModel: ObservableObject {
    @Published var selectedTab = 0
    let tabItems = [
            (title: "Matchs", iconNameOn: "MatchsOn", iconNameOff: "MatchsOff"),
            (title: "Mes Paris", iconNameOn: "BetsOn", iconNameOff: "BetsOff"),
            (title: "Profil", iconNameOn: "ShopOn", iconNameOff: "ShopOff")
        ]
}
