//
//  CalendarView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 26/05/2026.
//


import SwiftUI
import EventKit
import Foundation
import SwiftData


// USAGE: Public views to search by date and name of event
// nav back to list view


struct CalendarView: View {
    // MARK: - ViewModel
@StateObject private var viewModel = EventViewModel()
    var body: some View {
        VStack {
            // MARK: Date picker
            DatePicker(
                "Select Date",
                selection: $viewModel.calendarSelectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .padding()

            // MARK: Search bar for event name
            TextField("Search for event by name", text: $viewModel.searchText, onCommit: viewModel.updateCalendarDateToFirstMatch)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.darkGray), lineWidth: 1.5)
                )
                .padding(.horizontal)
                .padding(.bottom, 8)

            // MARK: Event display
            Text("Events on \(viewModel.formattedCalendarDate):")
                .font(.headline)
                .padding(.top)
            // MARK: Error if no events for the selected date
            if viewModel.eventsForSelectedDate.isEmpty {
                Text("No events scheduled today")
                    .foregroundColor(.secondary)
                    .padding()
                    // MARK:Show events for the selected date 
            } else {
                List(viewModel.eventsForSelectedDate, id: \.event_id) { event in
                    VStack(alignment: .leading) {
                        Text("\(event.eventName) (\(event.eventLocation))")
                            .font(.body)
                        Text(event.eventDescription)
                            .font(.subheadline)
                        Text("£\(String(format: "%.2f", event.ticketPrice))")
                            .font(.caption)
                        Text("\(viewModel.formatted(date: event.eventStart)) - \(viewModel.formatted(date: event.eventEnd))")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .task {
            await viewModel.fetchEventsFromAPI()
        }
    }
    

}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
