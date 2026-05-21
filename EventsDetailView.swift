//
//  EventsDetailView.swift
//  Event_Manager_MVP
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI

struct EventsDetailView: View {
    var body: some View {
        
        //       Call API and loop through cards to display more details for each card save and back buttons nested in VStack
        VStack{
            //        MARK: Top nav button
            Button {
            } label: {
                Label("Back to browse events", systemImage: "arrow.left")
            }
//            PLACEHOLDER REPLACE WITH NAV
//            NavigationLink(destination: EventsListView()) {
//                Label("Back to browse events", systemImage: "arrow.left")
//            }
            .frame(maxWidth: .infinity, alignment: .leading)
            EventCard()
            //        MARK: Save button
            Button {
                
            } label: {
                Label("Save to faves", systemImage: "heart.fill")
            }
        }
    }
}

#Preview {
    EventsDetailView()
}
