import SwiftUI

struct GameSetupView: View {
    @State var game: Game
    let allTeams: [Team]
    var onSave: () -> Void
    var onCancel: () -> Void

    var body: some View {
        NavigationView {
            Form {
                Picker("Home Team", selection: $game.homeTeamID) {
                    ForEach(allTeams) { team in
                        Text(team.name).tag(team.id)
                    }
                }
                Picker("Away Team", selection: $game.awayTeamID) {
                    ForEach(allTeams) { team in
                        Text(team.name).tag(team.id)
                    }
                }
                // Other fields
            }
            .navigationTitle("Set Up Game")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { onCancel() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { onSave() }
                }
            }
        }
    }
}