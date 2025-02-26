import SwiftUI

struct PlayerMarker: View {
    let player: Player
    let position: Game.Position?
    let playedTime: Int

    var body: some View {
        VStack(spacing: 2) {
            Text(playedTime.toMMSS())
                .font(.caption2)
                .foregroundColor(.gray)
            Text("\(player.number)")
                .font(.headline)
                .frame(width: 30, height: 30)
                .background(Color.blue.opacity(0.8))
                .clipShape(Circle())
            Text("\(player.firstName) \(player.lastName.prefix(1)).")
                .font(.caption)
        }
        .padding(6)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(8)
    }
}

extension Int {
    func toMMSS() -> String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}