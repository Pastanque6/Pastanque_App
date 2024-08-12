import SwiftUI

struct AvatarView: View {
    @Binding var selectedAvatar: String
    var backAction: () -> Void
    
    let avatars = ["avatar1", "avatar2", "avatar3", "avatar4", "avatar5", "avatar6", "avatar7", "avatar8", "avatar9", "avatar10", "avatar11", "avatar12"]
    
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 16), count: 3)
    
    var body: some View {
        VStack {
            HStack {
                Button(action: backAction) {
                    Image(systemName: "chevron.left")
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.customWhite)
                }
                
                Spacer()
                
                Text("Avatar")
                    .font(.custom(FontStyles.medium, size: FontStyles.normal))
                    .foregroundColor(Color.customWhite)
                
                Spacer()
                
                Image(systemName: "chevron.left")
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.clear)
                    .disabled(true)
            }
            .padding(.bottom, 16)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(avatars, id: \.self) { avatar in
                        Image(avatar)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 96, height: 96)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(selectedAvatar == avatar ? Color.customPrimary : Color.grey100, lineWidth: 1)
                            )
                            .onTapGesture {
                                self.selectedAvatar = avatar
                            }
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
        }
    }
}
