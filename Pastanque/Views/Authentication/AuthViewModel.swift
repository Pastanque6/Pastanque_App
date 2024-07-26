import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?
    @Published var leaguesBySport: [String: [League]] = [:]
    @Published var availableSports: [String] = []
    
    private var db = Firestore.firestore()
    
    init() {
        // Check if user is already authenticated
        if Auth.auth().currentUser != nil {
            fetchUser()
        }
    }
    
    func fetchAvailableLeagues(completion: @escaping () -> Void) {
        db.collection("leagues").whereField("available", isEqualTo: true).getDocuments { snapshot, error in
            if let error = error {
                print("Failed to fetch leagues: \(error.localizedDescription)")
                self.leaguesBySport = [:]
                self.availableSports = []
                completion()
                return
            }
            
            var leaguesBySport: [String: [League]] = [:]
            
            snapshot?.documents.forEach { document in
                let data = document.data()
                let sport = data["sport"] as? String ?? "Unknown"
                let id = data["sport_key"] as? String ?? "Unknown"
                let name = data["name"] as? String ?? "Unknown"
                let country = data["country"] as? String ?? "Unknown"
                
                let league = League(id: id, name: name, sport: sport, country: country)
                
                if leaguesBySport[sport] == nil {
                    leaguesBySport[sport] = []
                }
                leaguesBySport[sport]?.append(league)
            }
            
            self.leaguesBySport = leaguesBySport
            self.availableSports = SportsConfig.sportsOrder.filter { leaguesBySport.keys.contains($0) }
            completion()
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
                
                let user = User(
                    id: uid,
                    username: username,
                    phoneNumber: phoneNumber,
                    credits: 50.0,
                    gems: 1000,
                    unlockedLeagues: [selectedLeague]
                )
                self.db.collection("users").document(uid).setData([
                    "username": user.username,
                    "phoneNumber": user.phoneNumber,
                    "credits": user.credits,
                    "gems": user.gems,
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
                let credits = data?["credits"] as? Double ?? 0.0
                let gems = data?["gems"] as? Int ?? 0
                let unlockedLeagues = data?["unlockedLeagues"] as? [String] ?? []
                self.user = User(
                    id: uid,
                    username: username,
                    phoneNumber: phoneNumber,
                    credits: credits,
                    gems: gems,
                    unlockedLeagues: unlockedLeagues
                )
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
