//
//  EventCard.swift
//  Event_Manager_MVP
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI

struct EventCard: View {
    // MARK: stubbing with local state vars
    @State private var eventName: String = "Chelsea Flower Show"
    @State private var eventDescription: String = "Annual flower shower held in London organised by the Royal Horticultural Society"
    @State private var eventStart: Date = Date().addingTimeInterval(60*60*24)
    @State private var eventEnd: Date = Date().addingTimeInterval(60*60*24*7)
    var body: some View {
        
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.white),
                    Color(.lightGray)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(spacing: 20) {
                //        MARK: event name
                HStack {
                    Label {
                        Text(eventName)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } icon: {
                        Image(systemName: "pencil")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                //        MARK: event description
                HStack {
                    Label {
                        Text(eventDescription)
                            .frame(maxWidth: 350, alignment: .leading)
                    } icon: {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.blue)
                    }
                }
                //               align constrained event description to left
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                //        MARK: start and end dates
                
                HStack {
                    Label {
                        Text("Start: \(eventStart.formatted(date: .abbreviated, time: .omitted))")
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                .padding(.horizontal)
                HStack{
                    Label {
                        Text("End: \(eventEnd.formatted(date: .abbreviated, time: .omitted))")
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .cornerRadius(16)
            }
        } // End of V Stack
    } // End of Z stack
}

#Preview {
    EventCard()
}
