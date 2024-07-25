import SwiftUI

struct MatchStartTime: View {
    let commenceTime: Date
    
    var formattedStartTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM - HH:mm"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: commenceTime)
    }
    
    var body: some View {
        HStack {
            Text(formattedStartTime)
                .font(.custom(FontStyles.medium, size: FontStyles.xsmall))
                .foregroundColor(Color.grey100)
        }
        .frame(height: 18)
    }
}
