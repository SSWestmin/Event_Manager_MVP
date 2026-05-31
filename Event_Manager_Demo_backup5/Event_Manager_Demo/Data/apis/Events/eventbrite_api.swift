////
////  event_api.swift
////  Event_Manager_Demo
////
////  Created by Sumi Sastri on 22/05/2026.
////
//
//
//import Foundation
//import SwiftData
////import GCDWebServer
//
//// GCDWebServer imported for the OAuth authorization code
//// from the provider during the login/authentication process.
//// In Xcode, go to File > Add Packages...
//// Enter the URL: https://github.com/swisspol/GCDWebServer
//// Add the package to your project and target.
//// Clean and rebuild your project.
//// coco-pods??
//
//
//// MARK: - EventAPIResponse for Eventbrite API
//struct EventAPIResponse: Codable {
//    let events: [EventAPI]
//}
//
////  MARK: - EventAPIService secrets - do not commit
//@MainActor
//class EventAPIService {
//    //    MARK: Hardcoding secrets added to Plist
//    // MARK: - Localhost OAuth Redirect Handler (GCDWebServer)
//    // To use this, add GCDWebServer via Swift Package Manager: https://github.com/swisspol/GCDWebServer
//    // This function starts a local server to listen for the OAuth redirect
//    // Call this before opening the OAuth authorization URL in Safari
//    // Note this is read only - creator not updated or fixed for 7 years
//    
////    private var webServer: GCDWebServer?
//    
//    
//    /// Starts a local web server to listen for the OAuth redirect on http://localhost:8080/callback
//    /// - Parameter onCodeReceived: Closure called with the authorization code
//    func startOAuthRedirectServer(onCodeReceived: @escaping (String) -> Void) {
//#if canImport(GCDWebServer)
//        let server = GCDWebServer()
//        // find the callback path and extract the code from query parameters
//        server.addHandler(forMethod: "GET", path: "/callback", request: GCDWebServerRequest.self) { request in
//            if let code = request.query?["code"] as? String {
//                DispatchQueue.main.async {
//                    onCodeReceived(code)
//                }
//                return GCDWebServerDataResponse(html: "<html><body>Authorization successful. You may close this window.</body></html>")
//            } else {
//                return GCDWebServerDataResponse(html: "<html><body>Authorization code not found.</body></html>")
//            }
//        }
//        try? server.start(options: ["Port": 8080, "BindToLocalhost": true])
//        self.webServer = server
//#else
//        print("GCDWebServer not available. Please add it via Swift Package Manager.")
//#endif
//    }
//    
//    /// Stops the local web server
//    func stopOAuthRedirectServer() {
//#if canImport(GCDWebServer)
//        webServer?.stop()
//        webServer = nil
//#endif
//    }
//    
//    //    https://www.eventbriteapi.com/v3/users/me/?token=BCGQTQAFYXNSFTURDAO7 - 200 OK
//    // MARK: - Fetch Events from Eventbrite API
//    func fetchEvents() async throws -> [EventAPI] {
//        let eventsURL = "https://www.eventbriteapi.com/v3/users/me/events/"
//        guard let url = URL(string: eventsURL) else {
//            throw NetworkError.invalidURL
//        }
//        //        MARK: Get events request
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        //        MARK: To get events - both bearer token and api required to auth user
//        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//        do {
//            let (data, response) = try await URLSession.shared.data(for: request)
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                throw NetworkError.invalidResponse
//            }
//            //            MARK: test
//            let decoded = try JSONDecoder().decode(EventAPIResponse.self, from: data)
//            return decoded.events
//        } catch {
//            // Fallback logic commented out
//            /*
//             guard let fallbackURL = URL(string: "https://mocki.io/v1/your-mock-endpoint-id") else {
//             throw NetworkError.invalidURL
//             }
//             var fallbackRequest = URLRequest(url: fallbackURL)
//             fallbackRequest.httpMethod = "GET"
//             let (fallbackData, fallbackResponse) = try await URLSession.shared.data(for: fallbackRequest)
//             guard let fallbackHTTPResponse = fallbackResponse as? HTTPURLResponse, fallbackHTTPResponse.statusCode == 200 else {
//             throw NetworkError.invalidResponse
//             }
//             let fallbackDecoded = try JSONDecoder().decode(FallbackEventAPIResponse.self, from: fallbackData)
//             return fallbackDecoded.events
//             */
//            throw error
//        }
//    }
//    
//    // MARK: - OAuth2 Flow
//    // Note: In a real app, the clientID, clientSecret, and redirectURI should be securely stored and not hardcoded
//    func getOAuthAuthorizationURL(clientID: String, redirectURI: String) -> URL? {
//        var components = URLComponents(string: "https://www.eventbrite.com/oauth/authorize")
//        components?.queryItems = [
//            URLQueryItem(name: "response_type", value: "code"),
//            URLQueryItem(name: "client_id", value: clientID),
//            URLQueryItem(name: "redirect_uri", value: redirectURI)
//        ]
//        return components?.url
//    }
//    
//    
//    // MARK: - Exchange authorization code for access token
//    func exchangeCodeForToken(code: String, clientID: String, clientSecret: String, redirectURI: String) async throws -> String {
//        // Now we have the auth code!
//        // Let's exchange it for an access token
//        guard let url = URL(string: "https://www.eventbrite.com/oauth/token") else {
//            throw NetworkError.invalidURL
//        }
//        // access token request requires POST with form-encoded body
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        let body = "grant_type=authorization_code&client_id=\(clientID)&client_secret=\(clientSecret)&code=\(code)&redirect_uri=\(redirectURI)"
//        request.httpBody = body.data(using: .utf8)
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        // Perform the token exchange request
//        let (data, response) = try await URLSession.shared.data(for: request)
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            throw NetworkError.invalidResponse
//        }
//        
//        // The response will contain the access token in JSON format, e.g. { "access_token": "your_access_token", ... }
//        struct TokenResponse: Codable { let access_token: String }
//        // Decode the token response and return the access token
//        let decoded = try JSONDecoder().decode(TokenResponse.self, from: data)
//        return decoded.access_token
//    }
//}
//
//// MARK: - EventAPI Model for Eventbrite
//struct EventAPI: Codable, Identifiable {
//    let id: String
//    let name: Name
//    let description: Description?
//    let start: EventDate
//    let end: EventDate
//    let url: String?
//}
//
//struct Name: Codable {
//    let text: String?
//}
//
//struct Description: Codable {
//    let text: String?
//}
//
//struct EventDate: Codable {
//    let timezone: String?
//    let local: String?
//    let utc: String?
//}
//
//// MARK: - Mapping from EventAPI to EventModel
//extension EventModel {
//    convenience init?(from api: EventAPI) {
//        // Parse dates from Eventbrite's local date string (ISO8601)
//        let dateFormatter = ISO8601DateFormatter()
//        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
//        // Fallback if fractional seconds are not present
//        func parseDate(_ str: String?) -> Date? {
//            guard let str = str else { return nil }
//            return dateFormatter.date(from: str) ?? ISO8601DateFormatter().date(from: str)
//        }
//        guard
//            let eventName = api.name.text,
//            let eventStart = parseDate(api.start.local),
//            let eventEnd = parseDate(api.end.local)
//        else {
//            return nil // Required fields missing or invalid
//        }
//        let eventDescription = api.description?.text ?? ""
//        self.init(
//            event_id:UUID(),
//            eventName: eventName,
//            eventDescription: eventDescription,
//            eventStart: eventStart,
//            eventEnd: eventEnd,
//            eventLocation: "", // Eventbrite API: add mapping if location is available
//            ticketPrice: 0.0,   // Eventbrite API: add mapping if price is available
//            latitude: 0.0,
//            longitude: 0.0,
//            created: Date(),
//            changed: Date(),
//        )
//    }
//}
