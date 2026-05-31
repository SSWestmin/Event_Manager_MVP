//
//  AtendeeListView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 24/05/2026.
//

import SwiftUI

// USAGE: Attendee to continue as auth user to browse events

struct AtendeeListView: View {
    @ObservedObject var viewModel: EventViewModel
    @State private var savedEvents: [EventModel] = []

    var body: some View {
        VStack {
            // MARK: Top Bar
            HStack {
                Spacer()
                Button {
                    // Logout action return to EventListView
                } label: {
                    Label("Logout", systemImage: "person.crop.circle.badge.xmark")
                        .font(.headline)
                }
            }
            .padding(.horizontal)
            .padding(.top)

            // MARK: Saved events
            SavedEventsView(savedEvents: savedEvents, viewModel: viewModel)
        }
    }
}
#Preview {
    AtendeeListView(viewModel: EventViewModel())
}
