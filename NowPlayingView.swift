import SwiftUI
import FirebaseFirestore

struct NowPlayingView: View {
    @ObservedObject var viewModel: NowPlayingViewModel
    @EnvironmentObject var authState: AuthState
    @State private var selectedTab: TabSelection = .lineup
    
    enum TabSelection {
        case lineup, events, statistics
    }
    
    var body: some View {
        VStack(spacing: 0) {
            GameHeaderView(viewModel: viewModel)
            TabControlView(selectedTab: $selectedTab)
            switch selectedTab {
            case .lineup:
                LineupView(viewModel: viewModel)
            case .events:
                EventsView(events: viewModel.game.events.map { 
                    DisplayEvent(description: "\($0.type) at \($0.minute)'") 
                })
            case .statistics:
                StatisticsView(game: viewModel.game)
            }
            Spacer()
        }
        .navigationTitle("Now Playing")
        .onAppear {
            if viewModel.game.status == .nowPlaying {
                viewModel.startMatchTimer()
            }
        }
        .onDisappear {
            viewModel.stopMatchTimer()
        }
    }
}