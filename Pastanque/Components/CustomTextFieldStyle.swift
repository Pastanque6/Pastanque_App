import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    var backgroundColor: Color
    var cornerRadius: CGFloat = 8
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .foregroundColor(.customPrimary)
    }
}
