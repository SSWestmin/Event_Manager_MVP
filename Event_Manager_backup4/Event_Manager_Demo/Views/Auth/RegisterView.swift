//
//  RegisterView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI

// USAGE: Register - auth assign user role and route
// toggle for registered users to login

struct RegisterView: View {
    // MARK: stubbing to be replaced with supabase auth
    @State private var userName: String = ""
    @State private var userEmail: String = ""
    @State private var userMobilePhone: String = ""
    @State private var userPassword: String = ""
    @State private var selectedRole: String = ""
    @State private var agreeToTerms: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        .white,
                        Color.yellow.opacity(0.25)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                //        MARK: Nested V Stack to scroll
                ScrollView {
                    VStack(spacing: 24) {
                        //        MARK: Reg toggle
                        VStack(spacing: 8) {
                            Text("Register")
                                .font(.largeTitle.bold())
                            HStack(spacing: 4) {
                                Text("Already a user?")
                                    .foregroundColor(.secondary)
                                Button("Login") {
                                }
                                .fontWeight(.semibold)
                            }
                        }
                        .padding(.top, 40)
                        //        MARK: Reg form fields
                        VStack(spacing: 18) {
                            TextField("Name", text: $userName)
                                .textFieldStyle(.roundedBorder)
                            TextField("Email", text: $userEmail)
                                .textFieldStyle(.roundedBorder)
                            TextField("Mobile", text: $userMobilePhone)
                                .textFieldStyle(.roundedBorder)
                            
                            SecureField("Password", text: $userPassword)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding(24)
                        .background(.yellow.opacity(0.25))
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        VStack(alignment: .leading, spacing: 16) {
                            //        MARK: Auth role assignment
                            Picker("Account Type", selection: $selectedRole) {
                                Text("Event Attendee")
                                    .tag("Event Attendee")
                                
                                Text("Event Admin")
                                    .tag("Event Admin")
                            }
                            .pickerStyle(.segmented)
                            .padding(24)
                            .background(.white.opacity(0.9))
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            .shadow(radius: 6)
                            //        MARK: Create account button
                            Button {
                            } label: {
                                Text("Create Account")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                            .padding(.top, 8)
                            
                            Toggle(
                                "By registering I confirm I am above 18 years and that I agree to the EventRabbit Privacy Policy",
                                isOn: $agreeToTerms
                            )
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
