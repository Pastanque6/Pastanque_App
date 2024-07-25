import SwiftUI

struct HeaderView: View {
    var username : String
    var gems : Int
    var credits : Double
    var currencyType : CurrencyType
    
    var body: some View {
        HStack {
            Text("Pastanque")
            
            Spacer()
            
            switch currencyType {
            case .credits:
                CreditsValue(valueText: "\(NumberFormatter.formatNumber(credits))", imageName: "PSTCoins")
            case .gems:
                CreditsValue(valueText: "\(gems)", imageName: "PSTGems")
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
    }
}
