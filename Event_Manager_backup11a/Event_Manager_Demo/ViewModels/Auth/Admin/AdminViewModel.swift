//
//  AdminViewModel.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 20/06/2026.
//

import Foundation
import SwiftData
import Combine

// USAGE: Manages authentication state and UI logic for user sign-in flows.
// Delegates persistence operations to the AuthCoordinator.
// Handles role assignment, loading state, and navigation decisions.


final class AdminViewModel: EventViewModel {

	var managedEvents: [EventModel] {
		filteredEvents
	}

	func createNewEvent(_ event: EventModel) {
		createEvent(event)
	}

	func updateExistingEvent(_ updated: EventModel) {
		updateEvent(updated)
	}

	func deleteExistingEvent(id: UUID) {
		deleteEvent(id: id)
	}

}
