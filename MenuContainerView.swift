import SwiftUI

struct MenuContainerView: View {
    @State private var selectedTab: Int = 0
    @State private var showMenu: Bool = false
    @EnvironmentObject var authState: AuthState

    var body: some View {
        ZStack {
            NavigationView {
                TabView(selection: $selectedTab) {
                    GameView()
                        .tag(0)
                    TeamView()
                        .tag(1)
                    PlayerView()
                        .tag(2)
                    SettingsView()
                        .tag(3)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { showMenu.toggle() }) {
                            Image(systemName: "line.horizontal.3")
                        }
                    }
                }
            }
            if showMenu {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showMenu = false
                    }
                HStack {
                    SideMenuView(selectedTab: $selectedTab, showMenu: $showMenu)
                        .offset(x: 0)
                    Spacer()
                }
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: showMenu)
    }
}