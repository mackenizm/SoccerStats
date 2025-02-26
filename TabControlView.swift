import SwiftUI

struct TabControlView: View {
    @Binding var selectedTab: NowPlayingView.TabSelection

    var body: some View {
        Picker("Tab", selection: $selectedTab) {
            Text("Lineup").tag(NowPlayingView.TabSelection.lineup)
            Text("Events").tag(NowPlayingView.TabSelection.events)
            Text("Stats").tag(NowPlayingView.TabSelection.statistics)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}