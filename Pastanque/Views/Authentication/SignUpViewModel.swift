import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var username: String = "" {
        didSet {
            updateFormValidity()
        }
    }
    @Published var phoneNumber: String = "" {
        didSet {
            updateFormValidity()
        }
    }
    @Published var avatar: String = "avatar1"
    @Published var currentStep: Int = 1
    @Published var acceptedRules: Bool = false
    @Published var selectedLeagueKey: String? = nil
    @Published var errorMessage: String?
    @Published var isSignedUp: Bool = false
    @Published var usernameErrorMessage: String = ""
    @Published var phoneNumberErrorMessage: String = ""
    @Published var isFormValid: Bool = false

    func validateUsername() {
        let validator = InputValidator()
        if !validator.validateUsername(username: username) {
            usernameErrorMessage = "Le nom d'utilisateur doit contenir au moins 3 caractères."
        } else {
            usernameErrorMessage = ""
        }
        updateFormValidity()
    }
    
    func validatePhoneNumber() {
        let validator = InputValidator()
        if !validator.validatePhoneNumber(phoneNumber: phoneNumber) {
            phoneNumberErrorMessage = "Le téléphone doit contenir au moins 5 caractères."
        } else {
            phoneNumberErrorMessage = ""
        }
        updateFormValidity()
    }
    
    func updateFormValidity() {
        isFormValid = usernameErrorMessage.isEmpty &&
                      phoneNumberErrorMessage.isEmpty &&
                      !username.isEmpty &&
                      !phoneNumber.isEmpty
    }
    
    @MainActor
    func validateAndNextStep() async {
        validateUsername()
        validatePhoneNumber()
        
        if isFormValid {
            nextStep()
        } else {
            print("Validation failed.")
        }
    }

    func nextStep() {
        switch currentStep {
        case 1:
            if isFormValid {
                currentStep += 1
            }
        case 2:
            if acceptedRules {
                currentStep += 1
            }
        case 3:
            if selectedLeagueKey != nil {
                currentStep += 1
            }
        default:
            break
        }
    }

    func previousStep() {
        if currentStep > 1 {
            currentStep -= 1
        }
    }

    func completeSignUp(authViewModel: AuthViewModel) async {
        guard let selectedLeagueKey = selectedLeagueKey else {
            print("No league selected")
            return
        }

        authViewModel.signUp(username: username, phoneNumber: phoneNumber, avatar: avatar, selectedLeague: selectedLeagueKey) { success in
            DispatchQueue.main.async {
                if success {
                    self.isSignedUp = true
                    authViewModel.isLoggedIn = true
                } else {
                    self.errorMessage = authViewModel.errorMessage
                    print("Sign-up failed with error: \(self.errorMessage ?? "Unknown error")")
                }
            }
        }
    }
}
