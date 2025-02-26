import SwiftUI

struct PlayerDetailsView: View {
    let player: Player

    var body: some View {
        VStack {
            Text("\(player.firstName) \(player.lastName)")
                .font(.headline)
            Text("Number: \(player.number)")
            Text("Captain: \(player.isCaptain ? "Yes" : "No")")
            Spacer()
        }
        .padding()
    }
}