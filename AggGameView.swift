import SwiftUI

struct AggGameView: View {
    @ObservedObject var viewModel: GameViewModel

    var totalGames: Int { viewModel.games.count }
    var totalGoals: Int { viewModel.games.reduce(0) { $0 + $1.homeScore + $1.awayScore } }

    var body: some View {
        VStack(spacing: 20) {
            Text("Total Games: \(totalGames)")
                .font(.headline)
            Text("Total Goals: \(totalGoals)")
                .font(.headline)
        }
        .navigationTitle("Aggregated Stats")
    }
}