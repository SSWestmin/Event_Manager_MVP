//
//  AttendeeView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 24/05/2026.
//

import SwiftUI

// USAGE: Attendee to continue as auth user to see list of saved events and cancel event or ask for refund

struct AttendeeView: View {
    var body: some View {
        VStack{
            //        MARK: title
            Text("Registered Events")
                .font(.title)
                .padding()
            //        MARK: Top nav button
            Button {
            } label: {
                Label("Back to browse events", systemImage: "arrow.left")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            //        MARK: reusable event card
            EventCard()
            // MARK: Bottom cancel registration button
            HStack {
                Button {
                } label: {
                    Label("Cancel Registration", systemImage: "sign.fill")
                }
                
            }
        }
    }
}
#Preview {
    AttendeeView()
}
