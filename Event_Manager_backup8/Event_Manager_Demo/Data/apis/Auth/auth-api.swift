//
//  auth-api.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 15/06/2026.
//

import Foundation

// USAGE Request Payload
// This is the data we send when creating a new account
// AuthRegistrationInput and AuthRegistrationResponse 
// are already acting as DTOs no further mapping required at the moment

@MainActor
struct AuthRegistrationInput: Sendable, Codable {
	let userName: String
	let userEmail: String
	let userMobilePhone: String
	let userPassword: String
	let userRole: UserRole
}

// MARK: - Response Shape
// This is what the backend gives back after a successful registration.
struct AuthRegistrationResponse: Decodable {
	let userID: UUID
	let userName: String
	let userEmail: String
	let userMobilePhone: String
	let userRole: UserRole
}

// MARK: - Service Contract
// The view model talks to this protocol, not to the concrete service.
protocol AuthAPIServiceProtocol {
	func registerAccount(with input: AuthRegistrationInput) async throws -> AuthRegistrationResponse
}

// MARK: - Auth Service
// This is intentionally different from the event API because it sends data, 
// it does not fetch lists.
final class AuthAPIService: AuthAPIServiceProtocol {
	private let baseURL: URL
	private let session: URLSession

	init(baseURL: URL, session: URLSession = .shared) {
		self.baseURL = baseURL
		self.session = session
	}

	func registerAccount(with input: AuthRegistrationInput) async throws -> AuthRegistrationResponse {
		// Build the final registration URL from the injected base URL.
		let url = baseURL.appendingPathComponent("auth/register")

		// Build a POST request with JSON encoded account data.
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpBody = try JSONEncoder().encode(input)

		// Send the request and wait for the backend response.
		let (data, response) = try await session.data(for: request)

		// Fail early if the response is not HTTP.
		guard let httpResponse = response as? HTTPURLResponse else {
			throw NetworkError.invalidResponse
		}
// MARK: Add better error handling when auth fully incorporated
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }

		// Decode the success payload into a typed response.
		do {
			return try JSONDecoder().decode(AuthRegistrationResponse.self, from: data)
		} catch {
			throw NetworkError.decodingError
		}
	}
}

// MARK: - Server Error Shape
// Used only when the backend returns a human-readable error message.
private struct ServerErrorResponse: Decodable {
	let message: String
}
