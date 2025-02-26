import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @EnvironmentObject var authState: AuthState
    @State private var showingLogoutConfirmation = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Account Information")) {
                    Text("Email: \(authState.user?.email ?? "Not available")")
                    Text("Role: \(authState.role.rawValue.capitalized)")
                }
                
                Section {
                    Button("Log Out") {
                        showingLogoutConfirmation = true
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Settings")
            .alert("Confirm Logout", isPresented: $showingLogoutConfirmation) {
                Button("Cancel", role: .cancel) {}
                Button("Log Out", role: .destructive) {
                    do {
                        try Auth.auth().signOut()
                    } catch {
                        print("Error signing out: \(error.localizedDescription)")
                    }
                }
            } message: {
                Text("Are you sure you want to log out?")
            }
        }
    }
}