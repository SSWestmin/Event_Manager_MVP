//
//  UserModel.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 22/05/2026.
//

import Foundation
import SwiftData

// USAGE: Persisted user profile and role information.
// Auth handled by Sign in with Apple - no password storage required
// RBAC implemented via UserRole enum - default role is attendee

//
//enum UserRole: String, Codable, CaseIterable, Identifiable {
//    case attendee
//    case admin
//    var id: String { rawValue }
//}
//
//// MARK: Refactors required for Sign in with Apple - remove phone, password, user_ID use   appleUserID: String,
//@Model
//final class UserModel {
//    @Attribute(.unique) var userEmail: String
//    var user_id: UUID = UUID()
//    var userName: String
//    var userMobilePhone: String
//    //    var userRole: String
//    // MARK: Role stored locally - default attendee (principle of least privilege)
//    private var userRoleRawValue: String
//    var userPassword: String
//    var userCreatedAt: Date
//    var userUpdatedAt: Date
//    
//    // allocates role within the model using raw value
//    var userRole: UserRole {
//        get { UserRole(rawValue: userRoleRawValue) ?? .attendee }
//        set { userRoleRawValue = newValue.rawValue }
//    }
//    
//    // MARK: initialisation
//    init(
//        user_id: UUID,
//        userName: String,
//        userEmail: String,
//        userMobilePhone: String,
//        //        userRole: String,
//        userRole: UserRole,
//        userPassword: String,
//        userCreatedAt: Date,
//        userUpdatedAt: Date,
//    )
//    //MARK: Bindings
//    {
//        self.user_id = user_id
//        self.userName = userName
//        self.userEmail = userEmail
//        self.userMobilePhone = userMobilePhone
//        //        self.userRole = userRole
//        self.userRoleRawValue = userRole.rawValue
//        self.userPassword = userPassword
//        self.userCreatedAt = userCreatedAt
//        self.userUpdatedAt = userUpdatedAt
//    }
//    
//    // FUNCTIONS FOR DTO - MAPPING - IN SEPARATE FILE?
//    func touchUpdatedAt(_ date: Date = Date()) {
//        userUpdatedAt = date
//    }
//    
//}


enum UserRole: String, Codable, CaseIterable, Identifiable {
    case attendee
    case admin
    var id: String { rawValue }
}

@Model
final class UserModel {
    // MARK: Apple provides the stable unique identifier
    @Attribute(.unique) var appleUserID: String
    var userName: String
    var userEmail: String
    var userCreatedAt: Date
    // MARK: Role stored locally - default attendee (principle of least privilege)
    private var userRoleRawValue: String
    
    var userRole: UserRole {
        get { UserRole(rawValue: userRoleRawValue) ?? .attendee }
        set { userRoleRawValue = newValue.rawValue }
    }
    
    init(
        appleUserID: String,
        userName: String,
        userEmail: String,
        userRole: UserRole = .attendee,
        userCreatedAt: Date = Date()
    ) {
        self.appleUserID = appleUserID
        self.userName = userName
        self.userEmail = userEmail
        self.userRoleRawValue = userRole.rawValue
        self.userCreatedAt = userCreatedAt
    }
    
    func touchUpdatedAt(_ date: Date = Date()) {
        userCreatedAt = date
    }
}


