import SwiftUI

struct StatisticsView: View {
    let game: Game

    var body: some View {
        VStack(spacing: 10) {
            Text("Total Goals: \(game.homeScore + game.awayScore)")
            Text("Home Goals: \(game.homeScore)")
            Text("Away Goals: \(game.awayScore)")
        }
        .padding()
    }
}