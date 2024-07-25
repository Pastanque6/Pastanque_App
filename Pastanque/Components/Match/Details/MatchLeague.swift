import SwiftUI

struct MatchLeague: View {
    let leagueName: String
    let country: String
    
    var flagImageName: String {
        LeagueFlagMapper.flagName(for: country)
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Image(flagImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
            
            Text(leagueName)
                .font(.custom(FontStyles.medium, size: FontStyles.small))
                .foregroundColor(Color.grey100)
            
            Spacer()
        }
        .frame(height: 20)
    }
}
