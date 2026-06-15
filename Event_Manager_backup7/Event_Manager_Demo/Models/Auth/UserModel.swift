//
//  UserModel.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 22/05/2026.
//

import Foundation
import SwiftData

// USAGE: User Data pre-auth
// Note: maintain var order
@Model
final class UserModel {
    var user_id: UUID = UUID()
    var userName: String
    var userEmail: String
    var userMobilePhone: String
    var userRole: String
    var userPassword: String
    var userCreatedAt: Date
    var userUpdatedAt: Date
    // APIs and Auth
    //    userSegment
    //    eventbriteUserID
    //    authProviderID
    //    externalAuthProvider
    //    userStatus
    //    marketingConsent
    //    eventCount
    //    eventbriteAuthToken
    //    eventbriteRefreshToken
    //    organisationID
    
    // MARK: initialisation
    init(
        user_id: UUID,
        userName: String,
        userEmail: String,
        userMobilePhone: String,
        userRole: String,
        userPassword: String,
        userCreatedAt: Date,
        userUpdatedAt: Date,
    )
    //MARK: Bindings
    {
        self.user_id = UUID()
        self.userName = userName
        self.userName = userName
        self.userEmail = userEmail
        self.userMobilePhone = userMobilePhone
        self.userRole = userRole
        self.userPassword = userPassword
        self.userCreatedAt = Date()
        self.userUpdatedAt = Date()
    }
}

