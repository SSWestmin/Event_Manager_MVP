//
//  CalendarListView.swift
//  Event_Manager_Demo
//s
//  Created by Sumi Sastri on 26/05/2026.
//

import SwiftUI

struct CalendarListView: View {
    var body: some View {
        VStack{
            // Note: nav not required auto toggle with nav stack
            //         MARK: reusable calendar view
            CalendarView()
        }
    } // V Stack ends
}

#Preview {
    CalendarListView()
}
