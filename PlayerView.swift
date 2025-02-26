import SwiftUI

// Define AddPlayerView for the sheet
struct AddPlayerView: View {
    @Binding var number: String
    @Binding var firstName: String
    @Binding var lastName: String
    @Environment(\.dismiss) var dismiss
    var onSave: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Number", text: $number)
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                Button("Save") {
                    onSave()
                    dismiss()
                }
            }
            .navigationTitle("Add Player")
        }
    }
}

struct PlayerView: View {
    @EnvironmentObject var authState: AuthState
    @StateObject private var viewModel = PlayerViewModel()
    @State private var showingAddPlayer = false
    @State private var newPlayerNumber = ""
    @State private var newPlayerFirstName = ""
    @State private var newPlayerLastName = ""

    var body: some View {
        NavigationView {
            List(viewModel.players) { player in
                Text("\(player.number) - \(player.firstName) \(player.lastName)")
            }
            .navigationTitle("Players")
            .toolbar {
                // Only managers and admins can create/edit players
                if authState.role == .manager || authState.role == .admin {
                    Button(action: { showingAddPlayer = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddPlayer) {
                AddPlayerView(
                    number: $newPlayerNumber,
                    firstName: $newPlayerFirstName,
                    lastName: $newPlayerLastName,
                    onSave: {
                        if let number = Int(newPlayerNumber) {
                            viewModel.addPlayer(
                                number: number,
                                firstName: newPlayerFirstName,
                                lastName: newPlayerLastName
                            )
                            // Reset fields
                            newPlayerNumber = ""
                            newPlayerFirstName = ""
                            newPlayerLastName = ""
                        }
                    }
                )
            }
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
            .environmentObject(AuthState())
    }
}