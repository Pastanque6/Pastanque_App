import SwiftUI

struct Header: View {
    var avatar: String
    var username: String
    var gems: Int
    var credits: Double
    var currencyType: CurrencyType
    var onUsernameTap: () -> Void
    
    var body: some View {
        HStack {
            HStack {
                Button(action: onUsernameTap) {
                    
                    Image(avatar)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.customPrimary, lineWidth: 1)
                        )
                    
                    Text("\(username)")
                        .font(.custom(FontStyles.medium, size: FontStyles.normal))
                        .foregroundColor(.customPrimary)
                }
            }
            
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
