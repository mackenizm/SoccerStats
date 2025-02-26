import SwiftUI

struct GameHeaderView: View {
    @ObservedObject var viewModel: NowPlayingViewModel
    @EnvironmentObject var authState: AuthState

    var body: some View {
        VStack {
            Text("\(viewModel.game.homeTeamName) \(viewModel.game.homeScore) - \(viewModel.game.awayScore) \(viewModel.game.awayTeamName)")
                .font(.title2)
                .fontWeight(.bold)
            Text("Time: \(formattedTime(viewModel.matchTime))")
                .font(.subheadline)
            
            // All users can start/stop games now (not just managers/admins)
            HStack(spacing: 20) {
                Button(viewModel.isMatchRunning ? "Pause" : "Start") {
                    viewModel.isMatchRunning ? viewModel.stopMatchTimer() : viewModel.startMatchTimer()
                }
                .buttonStyle(.borderedProminent)
                Button("Save") {
                    viewModel.saveGame(for: authState.user?.uid ?? "")
                }
                .buttonStyle(.bordered)
            }
            .padding(.top, 10)
        }
        .padding()
        .background(Color(.systemGray6))
    }

    private func formattedTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
}