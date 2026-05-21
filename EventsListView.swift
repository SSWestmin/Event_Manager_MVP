//
//  EventsListView.swift
//  Event_Manager_MVP
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI


struct EventsListView: View {
    var body: some View {
        Text("Browse our events")
        HStack{
            Text("Map View")
            Text("Calendar View")
        }
        //       Call API and loop through cards to display more details nav in VStack
        VStack{
            EventPreviewCard()
            //                MARK: Bottom nav button
            Button {
            } label: {
                Label("More details", systemImage: "arrow.right")
            }
            .frame(maxWidth: 500, alignment: .trailing)
        }
        
    }
}

#Preview {
    EventsListView()
}




