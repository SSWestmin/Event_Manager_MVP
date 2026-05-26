//
//  CalendarListView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 26/05/2026.
//

import SwiftUI

struct CalendarListView: View {
    var body: some View {
        VStack{
            //        MARK: Top nav button
            Button {
            } label: {
                Label("Back to browse events", systemImage: "arrow.left")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            //         MARK: reusable calendar view
            CalendarView()
        }
    }
}

#Preview {
    CalendarListView()
}
