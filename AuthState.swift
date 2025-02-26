import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class AuthState: ObservableObject {
    @Published var loggedIn: Bool = false
    @Published var user: User? = nil
    @Published var role: UserRole = .user  // Default to lowest privilege

    enum UserRole: String, Codable {
        case user    // Base level: handle lineups, positions, game stats
        case manager // Mid level: everything user can do + create/edit games
        case admin   // Top level: everything
    }

    // Keep a handle if you plan to remove the listener later
    private var stateListenerHandle: AuthStateDidChangeListenerHandle?

    init() {
        // Ensure Firebase is configured once in your app's lifecycle
        FirebaseApp.configure()

        // Store the handle for listener cleanup
        stateListenerHandle = Auth.auth().addStateDidChangeListener { auth, user in
            self.loggedIn = (user != nil)
            self.user = user
            if let user = user {
                Firestore.firestore().collection("users").document(user.uid).getDocument { snapshot, error in
                    if let error = error {
                        print("Error fetching role: \(error.localizedDescription)")
                        return
                    }
                    if let data = snapshot?.data(),
                       let roleStr = data["role"] as? String {
                        self.role = UserRole(rawValue: roleStr) ?? .user
                    }
                }
            }
        }
    }

    deinit {
        // Remove this listener when AuthState is deallocated
        if let handle = stateListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}