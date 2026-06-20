//
//  AuthViewModel.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 15/06/2026.
//

import Foundation
import SwiftData
import Combine
import AuthenticationServices


// USAGE: Auth SSOT - handles Apple Sign In state + coordination

class AuthViewModel: ObservableObject {
    // MARK: No API call @Published vars removed
    // Refactored for Apple Sign In
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isSignedIn: Bool = false
    
    
    
    //     MARK: Empty initialiser refactored when data persitence added
    
    private let authCoordinator: AuthCoordinator
    
    init(authCoordinator: AuthCoordinator) {
        self.authCoordinator = authCoordinator
    }
    
    // MARK: initialisation legacy
    //    init() {}
    //    private let authService: AuthAPIServiceProtocol
    //
    //        init(authService: AuthAPIServiceProtocol) {
    //            self.authService = authService
    //        }
    //
    //    MARK: Registration business logic using Apple signin
    
    // MARK: Mock Apple Sign In for simulator testing without paid developer account
    // Used only when ASAuthorization cannot be tested locally
    func mockAppleSignIn(role: UserRole = .attendee) {
        isLoading = true
        errorMessage = nil
        
        let mockAppleUserID = "mock.\(UUID().uuidString)"
        let mockEmail = "test.user@icloud.com"
        let mockName = "Test User"
        
        Task {
            do {
                _ = try authCoordinator.saveUser(
                    appleUserID: mockAppleUserID,
                    userName: mockName,
                    userEmail: mockEmail,
                    userRole: role
                )
                await MainActor.run {
                    self.isSignedIn = true
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
//     MARK: Production code if paid version used

    func handleAppleSignIn(result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let auth):
            guard let credential = auth.credential as? ASAuthorizationAppleIDCredential else {
                errorMessage = "Invalid Apple credential"
                return
            }

            isLoading = true
            errorMessage = nil

            let appleUserID = credential.user
            let email = credential.email ?? ""
            let name = credential.fullName?.givenName ?? "User"

            Task {
                do {
                    _ = try authCoordinator.saveUser(
                        appleUserID: appleUserID,
                        userName: name,
                        userEmail: email,
                        userRole: .attendee
                    )

                    await MainActor.run {
                        self.isSignedIn = true
                        self.isLoading = false
                    }
                } catch {
                    await MainActor.run {
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                    }
                }
            }

        case .failure(let error):
            errorMessage = error.localizedDescription
        }
    }
}
    //    // MARK: Validation - legacy
    //    var formIsValid: Bool {
    //        !userName.isEmpty &&
    //        !userEmail.isEmpty &&
    //        !userPassword.isEmpty &&
    //        agreeToTerms
    //    }
    //
    //
    //    // MARK: Register
    //    func register() async {
    //        guard formIsValid else {
    //            errorMessage = "Please complete all fields and agree to terms."
    //            return
    //        }
    //        isLoading = true
    //        errorMessage = nil
    //        do {
    //            let input = AuthRegistrationInput(
    //                userName: userName,
    //                userEmail: userEmail,
    //                userMobilePhone: userMobilePhone,
    //                userPassword: userPassword,
    //                userRole: selectedRole
    //            )
    //            let _ = try await authService.registerAccount(with: input)
    //            registrationSuccess = true
    //        } catch {
    //            errorMessage = error.localizedDescription
    //        }
    //        isLoading = false
    //        //    MARK: Authentication of user credentials for login
    //
    //        //    MARK: Remove session authentication for logout
    //
    //    }
    //}
    //
    
    
    
    
    
    
    
    
    
    
    
