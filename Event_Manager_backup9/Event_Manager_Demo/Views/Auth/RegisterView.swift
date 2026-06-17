//
//  RegisterView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI
import SwiftData
import AuthenticationServices

// USAGE: Apple Sign In Registration View (UI driven by AuthViewModel)
// VIEWS NEED REFACTOR - VERY DIFFERENT WITH APPLE NO REGISTER-LOGIN
struct RegisterView: View {
    
    // MARK: Driven entirely by ViewModel (NO local form state)
    @StateObject var viewModel: AuthViewModel
    
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
                
                ScrollView {
                    VStack(spacing: 32) {
                        
                        // MARK: Header
                        VStack(spacing: 8) {
                            Text("Register")
                                .font(.largeTitle.bold())
                            
                            HStack(spacing: 4) {
                                Text("Already a user?")
                                    .foregroundColor(.secondary)
                                
                                Button("Login") {
                                    // navigation handled externally
                                }
                                .fontWeight(.semibold)
                            }
                        }
                        .padding(.top, 40)
                        
                        // MARK: Apple Sign In driven UI state
                        if viewModel.isLoading {
                            ProgressView("Signing you in...")
                        }
                        
                        if let error = viewModel.errorMessage {
                            Text(error)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                        }
                        
                        // MARK: Apple Sign In Button
                        SignInWithAppleButton(
                            .signUp,
                            onRequest: { request in
                                request.requestedScopes = [.fullName, .email]
                            },
                            onCompletion: viewModel.handleAppleSignIn
                        )
                        .signInWithAppleButtonStyle(.black)
                        .frame(height: 50)
                        .padding(.horizontal)
                        
                        // MARK: Status UI
                        if viewModel.isSignedIn {
                            Text("Registration successful")
                                .foregroundColor(.green)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(
        for: EventModel.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )
    let coordinator = AuthCoordinator(
        modelContext: container.mainContext
    )
    let vm = AuthViewModel(authCoordinator: coordinator)

    RegisterView(viewModel: vm)
        .modelContainer(container)
}
