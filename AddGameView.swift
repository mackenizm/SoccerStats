import SwiftUI
import FirebaseFirestore

struct AddGameView: View {
    // MARK: - State Variables
    @State private var homeTeam: Team?
    @State private var awayTeam: Team?
    @State private var allTeams: [Team] = []
    @State private var errorMessage: String?

    // MARK: - Closures
    let onSave: (Game) -> Void
    let onCancel: () -> Void

    // MARK: - Body
    var body: some View {
        NavigationView {
            Form {
                // Home Team Picker
                Picker("Home Team", selection: $homeTeam) {
                    Text("Select Home Team").tag(Team?.none)
                    ForEach(allTeams) { team in
                        Text(team.name).tag(Optional(team))
                    }
                }

                // Away Team Picker
                Picker("Away Team", selection: $awayTeam) {
                    Text("Select Away Team").tag(Team?.none)
                    ForEach(allTeams) { team in
                        Text(team.name).tag(Optional(team))
                    }
                }
            }
            .navigationTitle("Add Game")
            .toolbar {
                // Cancel Button
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: onCancel)
                }

                // Save Button
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveGame()
                    }
                    .disabled(homeTeam == nil || awayTeam == nil || homeTeam == awayTeam)
                }
            }
            .onAppear(perform: fetchTeams)
            .alert(isPresented: Binding(
                get: { errorMessage != nil },
                set: { if !$0 { errorMessage = nil } }
            )) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorMessage ?? "Unknown error"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    // MARK: - Helper Functions
    private func fetchTeams() {
        Firestore.firestore().collection("teams").getDocuments { snapshot, error in
            if let error = error {
                errorMessage = "Failed to load teams: \(error.localizedDescription)"
                return
            }
            allTeams = snapshot?.documents.compactMap { try? $0.data(as: Team.self) } ?? []
        }
    }

    private func saveGame() {
        guard let home = homeTeam, let away = awayTeam else {
            errorMessage = "Please select both teams"
            return
        }
        if home.id == away.id {
            errorMessage = "Home and away teams must be different"
            return
        }

        let newGame = Game(
            season: "2025",
            date: Date(),
            homeTeamID: home.id ?? "",
            awayTeamID: away.id ?? "",
            homeTeamName: home.name,
            awayTeamName: away.name,
            homeScore: 0,
            awayScore: 0,
            status: .upcoming
        )
        onSave(newGame)
    }
}