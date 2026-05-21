//
//  SavedEventsView.swift
//  Event_Manager_MVP
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI

struct SavedEventsView: View {
    var body: some View {
        VStack{
            EventCard()
            
            // MARK: Bottom nav buttons
                HStack {
                    
                    Button {
                    } label: {
                        Label("Register", systemImage: "sign.fill")
                    }
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
    SavedEventsView()
}
