import SwiftUI
import FirebaseFirestore

struct TeamView: View {
    @EnvironmentObject var authState: AuthState
    @StateObject private var viewModel = TeamViewModel()
    @State private var showingAddTeam = false

    var body: some View {
        NavigationView {
            List(viewModel.teams) { team in
                VStack(alignment: .leading) {
                    Text(team.name)
                        .font(.headline)
                    Text("Season: \(team.season)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Teams")
            .toolbar {
                if authState.role == .manager || authState.role == .admin {
                    Button(action: { showingAddTeam = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTeam) {
                AddTeamView(
                    teamName: "",
                    teamSeason: "",
                    onSave: { newTeam in
                        viewModel.addTeam(newTeam)
                        showingAddTeam = false
                    },
                    onCancel: { showingAddTeam = false }
                )
            }
            .onAppear {
                viewModel.fetchTeams()
            }
            .alert(isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            )) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? "Unknown error"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
