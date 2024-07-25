import SwiftUI

struct HeaderView<Content: View>: View {
 //   @ObservedObject var userData = User
    let content: Content
    let currencyType: CurrencyType
    
    init(currencyType: CurrencyType, @ViewBuilder content: () -> Content) {
        self.currencyType = currencyType
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
  //          Header(username: userData.username, gems: userData.gems, credits: userData.credits, currencyType: currencyType)
   //         content
        }
        .background(Color.grey600)
        }
    }
