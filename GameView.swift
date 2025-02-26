import SwiftUI

struct GameView: View {
    @EnvironmentObject var authState: AuthState
    @StateObject private var viewModel = GameViewModel()
    @State private var showingAddGame = false

    var body: some View {
        NavigationView {
            List(viewModel.games) { game in
                NavigationLink(destination: NowPlayingView(viewModel: NowPlayingViewModel(game: game))) {
                    Text("\(game.homeTeamName) vs \(game.awayTeamName)")
                }
            }
            .navigationTitle("Games")
            .toolbar {
                if authState.role == .manager || authState.role == .admin {
                    Button(action: { showingAddGame = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddGame) {
                AddGameView(onSave: { newGame in
                    viewModel.addGame(newGame, for: authState.user?.uid ?? "")
                    showingAddGame = false
                }, onCancel: { showingAddGame = false })
            }
            .onAppear {
                guard let userID = authState.user?.uid else { return }
                viewModel.fetchGames(for: userID)
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