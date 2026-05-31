//
//  event-api.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 31/05/2026.
//

import Foundation
// Ticketmaster models now in eventapi_DTO.swift

//  API call that works https://app.ticketmaster.com/discovery/v2/events.json?apikey=pypHQkdZs0DnFdduLAHt2pr5dUcq2Gzf

// MARK: - Event - API Service
@MainActor
class EventAPIService {
    private let baseURL = "https://app.ticketmaster.com/discovery/v2/events.json?"
//    move to secrets
    // private let apiKey="pypHQkdZs0DnFdduLAHt2pr5dUcq2Gzf"
    private var apiKey: String? {
        guard let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any],
              let key = plist["API_KEY"] as? String else {
            return nil
        }
        return key
    }
    
    /// Fetch events from Ticketmaster API for a given city
    func fetchArtEventsInLondon() async throws -> [TicketmasterEvent] {
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        // let apiKey=apiKey
        guard let apiKey = apiKey else {
            throw NetworkError.invalidURL // Or a custom error for missing API key
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: apiKey),
            URLQueryItem(name: "city", value: "London"),
            // NOTE: RESTRICT TO TEST
            // URLQueryItem(name: "classificationName", value: "arts")
        ]
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        do {
            let decoded = try JSONDecoder().decode(TicketmasterEventResponse.self, from: data)
            return decoded.embedded?.events ?? []
        } catch {
            throw NetworkError.decodingError
        }
    }
}
