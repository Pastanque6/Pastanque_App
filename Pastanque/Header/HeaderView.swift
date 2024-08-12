import SwiftUI

struct HeaderView<Content: View>: View {
    let currencyType: CurrencyType
    let avatar: String
    let username: String
    let gems: Int
    let credits: Double
    @Binding var showingProfile: Bool
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(spacing: 0) {
            Header(avatar: avatar, username: username, gems: gems, credits: credits, currencyType: currencyType, onUsernameTap: {
                self.showingProfile = true
            })
            content
        }
        .background(Color.grey600)
    }
}
