import SwiftUI

struct LineupView: View {
    @ObservedObject var viewModel: NowPlayingViewModel

    var body: some View {
        List(viewModel.homePlayers) { player in
            HStack {
                Text("\(player.number)")
                    .frame(width: 30)
                Text("\(player.firstName) \(player.lastName)")
            }
        }
    }
}