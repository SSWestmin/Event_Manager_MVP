//
//  AdminView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 22/05/2026.
//

import SwiftUI

// USAGE: Admin to manage events with CRUD actions

struct AdminView: View {
    var body: some View {
        //        MARK: title
        Text("Manage events")
            .font(.title)
            . padding()
        //       Call API and loop through cards to display more details nav in VStack
        //        MARK: create button
        Button {
        } label: {
            Label("Create event", systemImage: "pencil")
        }
        .frame(maxWidth: 500, alignment: .leading)
        //        MARK: reusable event preview card
        VStack{
            EventPreviewCard()
            //                MARK: Bottom nav buttons - archive & update event
            HStack{
                Button {
                } label: {
                    Label("Archive event", systemImage: "arrow.left")
                }
                .frame(maxWidth: 500, alignment: .leading)
                
                Button {
                } label: {
                    Label("Update event", systemImage: "arrow.right")
                }
                .frame(maxWidth: 500, alignment: .trailing)
            }
        }
    }
}

#Preview {
    AdminView()
}
