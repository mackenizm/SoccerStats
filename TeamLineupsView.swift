import SwiftUI
import FirebaseFirestore

struct TeamLineupsView: View {
    let team: Team
    @State private var updatedTeam: Team
    @EnvironmentObject var authState: AuthState
    private let db = Firestore.firestore()

    init(team: Team) {
        self.team = team
        _updatedTeam = State(initialValue: team)
    }

    var body: some View {
        VStack {
            List {
                ForEach(updatedTeam.lineupTemplates) { template in
                    Text(template.name)
                        .swipeActions {
                            if authState.role == .manager || authState.role == .admin {
                                Button(role: .destructive) {
                                    deleteTemplate(template)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                }
            }
            .navigationTitle("Lineup Templates for \(team.name)")
        }
    }

    private func deleteTemplate(_ template: Team.LineupTemplate) {
        updatedTeam.lineupTemplates = updatedTeam.lineupTemplates.filter { $0.id != template.id }
        guard let docID = team.id else { return }
        db.collection("teams").document(docID).updateData(["lineupTemplates": updatedTeam.lineupTemplates])
    }
}