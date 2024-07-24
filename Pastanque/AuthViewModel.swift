import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?
    
    private var db = Firestore.firestore()
    
    init() {
        // Check if user is already authenticated
        if Auth.auth().currentUser != nil {
            fetchUser()
        }
    }
    
    func fetchAvailableLeagues(completion: @escaping ([String]) -> Void) {
        db.collection("leagues").whereField("available", isEqualTo: true).getDocuments { snapshot, error in
            if let error = error {
                print("Failed to fetch leagues: \(error.localizedDescription)")
                completion([])
                return
            }
            
            let leagues = snapshot?.documents.compactMap { $0.data()["sport_key"] as? String } ?? []
            completion(leagues)
        }
    }
    
    func signUp(username: String, phoneNumber: String, selectedLeague: String, completion: @escaping (Bool) -> Void) {
        // Check if username is unique
        db.collection("users").whereField("username", isEqualTo: username).getDocuments { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to check username: \(error.localizedDescription)"
                completion(false)
                return
            }
            
            if snapshot?.documents.isEmpty == false {
                self.errorMessage = "Username already taken"
                completion(false)
                return
            }
            
            // Create a new user in Firebase Auth
            Auth.auth().signInAnonymously { authResult, error in
                if let error = error {
                    self.errorMessage = "Failed to sign up: \(error.localizedDescription)"
                    completion(false)
                    return
                }
                
                guard let uid = authResult?.user.uid else {
                    self.errorMessage = "Failed to get user ID"
                    completion(false)
                    return
                }
                
                let user = User(id: uid, username: username, phoneNumber: phoneNumber, unlockedLeagues: [selectedLeague])
                self.db.collection("users").document(uid).setData([
                    "username": user.username,
                    "phoneNumber": user.phoneNumber,
                    "unlockedLeagues": user.unlockedLeagues
                ]) { error in
                    if let error = error {
                        self.errorMessage = "Failed to save user data: \(error.localizedDescription)"
                        completion(false)
                        return
                    }
                    
                    self.user = user
                    self.isLoggedIn = true
                    completion(true)
                }
            }
        }
    }
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.collection("users").document(uid).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                let username = data?["username"] as? String ?? ""
                let phoneNumber = data?["phoneNumber"] as? String ?? ""
                let unlockedLeagues = data?["unlockedLeagues"] as? [String] ?? []
                self.user = User(id: uid, username: username, phoneNumber: phoneNumber, unlockedLeagues: unlockedLeagues)
                self.isLoggedIn = true
            } else {
                self.errorMessage = "User does not exist"
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
            self.user = nil
        } catch let error {
            self.errorMessage = "Failed to sign out: \(error.localizedDescription)"
        }
    }
}

