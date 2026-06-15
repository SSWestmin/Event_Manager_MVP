//
//  AuthViewModel.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 15/06/2026.
//

import Foundation
import SwiftData
import Combine


// USAGE: Register/Login SSOT enables users to register, login and logout

class AuthViewModel: ObservableObject {
    // MARK: Refactor - move state vars to VM
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    @Published var userMobilePhone: String = ""
    @Published var userPassword: String = ""
//    User role now an enum
    @Published var selectedRole: UserRole = .attendee
    @Published var agreeToTerms: Bool = false
//    MARK: Network calls
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var registrationSuccess: Bool = false
    
    //     MARK: Empty initialiser refactored when data persitence added

//    init() {}
    private let authService: AuthAPIServiceProtocol

        init(authService: AuthAPIServiceProtocol) {
            self.authService = authService
        }
    
    //    MARK: Business logic - create, update, delete registered user
    
    
    // MARK: Validation
    var formIsValid: Bool {
        !userName.isEmpty &&
        !userEmail.isEmpty &&
        !userPassword.isEmpty &&
        agreeToTerms
    }

    
    // MARK: Register
    func register() async {
        guard formIsValid else {
            errorMessage = "Please complete all fields and agree to terms."
            return
        }
        isLoading = true
        errorMessage = nil
        do {
            let input = AuthRegistrationInput(
                userName: userName,
                userEmail: userEmail,
                userMobilePhone: userMobilePhone,
                userPassword: userPassword,
                userRole: selectedRole
            )
            let _ = try await authService.registerAccount(with: input)
            registrationSuccess = true
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
        //    MARK: Authentication of user credentials for login
        
        //    MARK: Remove session authentication for logout
        
    }
}
    

    
    
    


        
    
    
    

