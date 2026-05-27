//

import SwiftUI

struct SavedEventsView: View {
    let savedEvents: [EventModel]
// Child view to show list of saved events for attendee
// Empty state till data passed from root to rest of the views 
    var body: some View {
        NavigationStack {
            VStack {
                Label("Saved Events", systemImage: "heart.fill")
                    .font(.title)
                if savedEvents.isEmpty {
                    Text("No saved events yet.")
                        .foregroundColor(.gray)
                } else {
                    List(savedEvents, id: \.event_id) { event in
                        NavigationLink(value: event) {
                            Text(event.eventName)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationDestination(for: EventModel.self) { event in
                EventCard(eventID: event.event_id)
            }
        }
    }
}

#Preview {
    SavedEventsView(savedEvents: [])
}
