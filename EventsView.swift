import SwiftUI

/// Rename to avoid colliding with Game.GameEvent
struct DisplayEvent: Identifiable {
    let id = UUID()         // Unique identifier for List
    let description: String // Property displayed in the List
}

struct EventsView: View {
    let events: [DisplayEvent] // Array of events to display
    
    var body: some View {
        List(events) { event in
            Text(event.description)
        }
        .navigationTitle("Events")
    }
}

// Optional: Preview provider for testing in Xcode
struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView(events: [
            DisplayEvent(description: "Goal scored by Player 10"),
            DisplayEvent(description: "Yellow card at 45'")
        ])
    }
}