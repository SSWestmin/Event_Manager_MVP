//
//  EventCard.swift
//  Event_Manager_Demo
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
@State private var eventLocation: String = "London, UK"
@State private var ticketPrice: Double = 20.00
    @State private var ticketDetails: String = "Full refund up to one week before event, 50% discount for group bookings"
    
var body: some View {
    ZStack{
        LinearGradient(
            gradient: Gradient(colors: [
                Color(.white),
                Color(.yellow.withAlphaComponent(0.5))
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        //        MARK: title
        VStack(spacing: 20) {
            Text("Event Details")
                .font(.title)
        
            //        MARK: Top nav button
            Button {
                
            } label: {
                Label("Back to browse events", systemImage: "arrow.left")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
//            MARK: state variables for API call refactor
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
            .padding(.horizontal)
            //              MARK: location
            HStack {
                Label {
                    Text(eventLocation)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } icon: {
                    Image(systemName: "pin.fill")
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            //              MARK: ticket price
            HStack {
                Label {
                    Text(ticketPrice, format: .currency(code: "GBP"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                } icon: {
                    Image(systemName: "ticket")
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            //        MARK: ticket refund policy
            HStack {
                Label {
                    Text(ticketDetails)
                        .frame(maxWidth: 350, alignment: .leading)
                } icon: {
                    Image(systemName: "arrow.2.circlepath.circle")
                        .foregroundColor(.blue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            //        MARK: Save button
            Button {
                
            } label: {
                Label("Save to faves", systemImage: "heart.fill")
            }
        }
    } // End of V Stack
} // End of Z stack
}

#Preview {
EventCard()
}
