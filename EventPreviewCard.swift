//
//  EventPreviewCard.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI

// USAGE: User browses events and clicks for more details
// Page navigates to EventCard with more complete details

struct EventPreviewCard: View {
    // MARK: stubbing with local state vars
    @State private var eventName: String = "Chelsea Flower Show"
    @State private var eventStart: Date = Date().addingTimeInterval(60*60*24)
    @State private var eventEnd: Date = Date().addingTimeInterval(60*60*24*7)
    @State private var eventLocation: String = "London, UK"
    var body: some View {
        
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.white),
                    Color(.yellow.withAlphaComponent(0.1))
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(spacing: 20) {
                //        MARK: event name & location
                HStack {
                    Label {
                        Text(eventName)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } icon: {
                        Image(systemName: "pencil")
                            .foregroundColor(.blue)
                    }
                    
                    Label {
                        Text(eventLocation)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } icon: {
                        Image(systemName: "pin.fill")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
               
                //        MARK: start and end dates
                
                HStack {
                    Label {
                        Text("Start: \(eventStart.formatted(date: .abbreviated, time: .omitted))")
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                    Label {
                        Text("End: \(eventEnd.formatted(date: .abbreviated, time: .omitted))")
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            
                .padding(.horizontal)
                Button("View Details") {
                }
            }
            
        } // End of V Stack
    } // End of Z stack
    }
#Preview {
    EventPreviewCard()
}
