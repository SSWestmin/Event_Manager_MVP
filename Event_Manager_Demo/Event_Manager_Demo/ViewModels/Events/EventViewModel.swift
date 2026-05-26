// import Foundation

// @MainActor
// class EventViewModel: ObservableObject {
// 	@Published var events: [EventModel] = []
// 	@Published var isLoading: Bool = false
// 	@Published var errorMessage: String? = nil

// 	private let apiService = EventAPIService()

// 	func fetchEvents() async {
// 		isLoading = true
// 		errorMessage = nil
// 		do {
// 			let apiEvents = try await apiService.fetchEvents()
// 			// Map EventAPI to EventModel
// 			let mapped = apiEvents.compactMap { EventModel(from: $0) }
// 			self.events = mapped
// 		} catch {
// 			self.errorMessage = error.localizedDescription
// 		}
// 		isLoading = false
// 	}
// }
