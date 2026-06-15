//
//  LoginView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI

// USAGE: Auth login with password or register

struct LoginView: View {
    // MARK: stubbing to be replaced with supabase auth
    @State private var userEmail: String = ""
    @State private var userPassword: String = ""
    
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
                VStack(spacing: 24) {
                    // MARK: Login heading
                    VStack(spacing: 8) {
                        Text("Login")
                            .font(.largeTitle.bold())
                        
                        Text("As a registered user you can login, search, save and register for events you wish to attend")
                        Spacer()
                        
                        HStack(spacing: 4) {
                            Text("New user?")
                                .foregroundColor(.secondary)
                            NavigationLink(destination: RegisterView()) {
                                Text("Register")
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    .padding(.top, 40)
                    // MARK: Login form fields
                    VStack(spacing: 18) {
                        TextField("Email", text: $userEmail)
                            .textFieldStyle(.roundedBorder)
                        SecureField("Password", text: $userPassword)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(24)
                    .background(.yellow.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(radius: 6)
                    // MARK: Login button
                    Button {
                    } label: {
                        Text("Login")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    LoginView()
}
