//
//  auth_mapping.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 15/06/2026.
//

import Foundation
import SwiftData

// USAGE: Mapping extension to convert user data - AuthRegistration response is a DTO

extension UserModel {
    convenience init(from response: AuthRegistrationResponse) {
        self.init(
            user_id: response.userID,
            userName: response.userName,
            userEmail: response.userEmail,
            userMobilePhone: response.userMobilePhone,
            userRole: response.userRole,
            userPassword: "",
            userCreatedAt: Date(),
            userUpdatedAt: Date()
        )
    }
}
