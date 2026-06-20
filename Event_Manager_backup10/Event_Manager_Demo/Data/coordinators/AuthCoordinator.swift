//
//  AuthCoordinator.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 17/06/2026.
//

import Foundation
import SwiftData

// MARK: Apple auth - no requirement for API call
// Refactored (API call deleted - no network call - local Apple storage)
// Delegation of user role at the point of authentication

@MainActor
final class AuthCoordinator {

    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func saveUser(
        appleUserID: String,
        userName: String,
        userEmail: String,
        userRole: UserRole
    ) throws -> UserModel {

        let descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate {
                $0.appleUserID == appleUserID
            }
        )

        if let existingUser = try modelContext.fetch(descriptor).first {
            return existingUser
        }

        let user = UserModel(
            appleUserID: appleUserID,
            userName: userName,
            userEmail: userEmail,
            userRole: userRole
        )

        modelContext.insert(user)
        try modelContext.save()

        return user
    }
}
