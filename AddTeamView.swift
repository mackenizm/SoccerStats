import SwiftUI

struct AddTeamView: View {
    @State var teamName: String
    @State var teamSeason: String
    var onSave: (Team) -> Void
    var onCancel: () -> Void

    let seasons = ["2025", "2026"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Team Name", text: $teamName)
                Picker("Season", selection: $teamSeason) {
                    ForEach(seasons, id: \.self) { season in
                        Text(season)
                    }
                }
            }
            .navigationTitle("Add Team")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { onCancel() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { onSave(Team(name: teamName, season: teamSeason)) }
                }
            }
        }
    }
}