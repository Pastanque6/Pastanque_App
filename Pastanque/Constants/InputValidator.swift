import Foundation

class InputValidator {
    // Valide que le nom d'utilisateur a au moins 3 caractères
    public func validateUsername(username: String) -> Bool {
        return username.count >= 3
    }
    
    public func validatePhoneNumber(phoneNumber: String) -> Bool {
        return phoneNumber.count >= 5
    }
}
