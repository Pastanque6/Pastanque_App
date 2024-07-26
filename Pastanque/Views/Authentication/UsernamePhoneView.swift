import SwiftUI

struct UsernamePhoneView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Inscription")
                .font(.custom(FontStyles.medium, size: FontStyles.xlarge))
                .foregroundColor(Color.customWhite)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Username", text: $viewModel.username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            TextField("Phone Number", text: $viewModel.phoneNumber)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            ActionButton(
                text: "Suivant",
                action: {
                    Task {
                        await viewModel.validateAndNextStep()
                    }
                },
                isEnabled: !viewModel.username.isEmpty && !viewModel.phoneNumber.isEmpty
            )
        }
        .padding(.horizontal, 16)
    }
}
