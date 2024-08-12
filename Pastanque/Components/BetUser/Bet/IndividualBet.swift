import SwiftUI

struct IndividualBet: View {
    let individualBet: UserBet
    var iconSportType: String {
            let icon = SportTypeMapper.iconName(for: individualBet.sportType)
            return UIImage(named: icon) != nil ? icon : "worldwide"
        }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 8) {
                Image(iconSportType)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 16, height: 16)
                Text("\(individualBet.homeTeam) - \(individualBet.awayTeam)")
                    .font(.custom(FontStyles.light, size: FontStyles.small))
                    .foregroundColor(Color.grey100)
            }
            HStack {
                Text(individualBet.userBet)
                    .font(.custom(FontStyles.light, size: FontStyles.normal))
                    .foregroundColor(Color.customWhite)
                
                Spacer()
                Text(NumberFormatter.formatNumber(individualBet.selectedOdds))
                    .font(.custom(FontStyles.medium, size: FontStyles.normal))
                    .foregroundColor(Color.customPrimary)
            }
        }
    }
}
