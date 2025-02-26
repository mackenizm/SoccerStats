import SwiftUI
import Firebase

@main
struct SoccerStatsApp: App {
    @StateObject var authState = AuthState()
    
    var body: some Scene {
        WindowGroup {
            if authState.loggedIn {
                MenuContainerView()
                    .environmentObject(authState)
            } else {
                LoginView()  // Line 14: Ensure LoginView.swift is in the target
                    .environmentObject(authState)
            }
        }
    }
}