//
//  ArchivedEventsView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 22/05/2026.
//

import SwiftUI

// USAGE: Admin to archive and then delete events
// Note: nav not required auto toggle with nav stack

struct ArchivedEventsView: View {
    @ObservedObject var viewModel: EventViewModel
    var body: some View {
        Label("Archive Events", systemImage: "document")
            .font(.title)
            .padding()
        VStack{
            EventCard(eventID: UUID(), viewModel: viewModel)
            HStack {
                Text("Keep or delete?")
                Spacer()
                Button {
                } label: {
                    Label("", systemImage: "trash")
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ArchivedEventsView(viewModel: EventViewModel())
}
