import SwiftUI

struct SideMenuView: View {
    @Binding var selectedTab: Int
    @Binding var showMenu: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            menuItem(title: "Games", tab: 0)
            menuItem(title: "Teams", tab: 1)
            menuItem(title: "Players", tab: 2)
            menuItem(title: "Settings", tab: 3)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(white: 0.9))
        .frame(width: 250)
    }

    private func menuItem(title: String, tab: Int) -> some View {
        Button(action: {
            selectedTab = tab
            showMenu = false
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(selectedTab == tab ? .blue : .black)
        }
    }
}