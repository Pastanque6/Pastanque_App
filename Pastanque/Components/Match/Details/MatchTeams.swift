import SwiftUI

struct MatchTeams: View {
    let homeTeam: String
    let awayTeam: String
    
    var body: some View {
        HStack {
            Text(homeTeam)
                .font(.custom(FontStyles.medium, size: FontStyles.normal))
                .foregroundColor(Color.customWhite)
                .multilineTextAlignment(.trailing)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            Spacer()
            
            Text("-")
                .font(.custom(FontStyles.medium, size: FontStyles.normal))
                .foregroundColor(Color.customWhite)
            
            Spacer()
            
            Text(awayTeam)
                .font(.custom(FontStyles.medium, size: FontStyles.normal))
                .foregroundColor(Color.customWhite)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 24)
    }
}
