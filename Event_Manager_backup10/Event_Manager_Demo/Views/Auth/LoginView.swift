//
//  LoginView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 21/05/2026.
//

// USAGE: With Apple signin there is no reg-login

import SwiftUI
import SwiftData

struct LoginView: View {
    @StateObject var viewModel: AuthViewModel

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.white, Color.yellow.opacity(0.25)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {
                VStack(spacing: 8) {
                    Text("Welcome to Event Rabbit")
                        .font(.largeTitle.bold())
                    Text("Sign in to browse, save and register for events")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 60)

                if viewModel.isLoading {
                    ProgressView("Signing you in...")
                }

                if viewModel.isSignedIn {
                    HStack(spacing: 12) {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.title2)
                            .foregroundColor(.green)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Sign in successful")
                                .font(.headline)
                            Text("You are now logged into the student demo app.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        Spacer()
                    }
                    .padding()
                    .background(Color.green.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .padding(.horizontal)
                    .transition(.opacity.combined(with: .scale))
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
//                 MARK: Mock sign in

                if !viewModel.isSignedIn {
                    VStack(spacing: 12) {
                        Button {
                            viewModel.mockAppleSignIn()
                        } label: {
                            Text("Demo Sign In")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }

                        Text("Production Apple Sign in is hidden for this student demo.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    
//                    if viewModel.isLoading {
//                        ProgressView("Signing you in...")
//                    }
//
//                    if let error = viewModel.errorMessage {
//                        Text(error)
//                            .foregroundColor(.red)
//                            .multilineTextAlignment(.center)
//                    }
//
//                    SignInWithAppleButton(
//                        .signIn,
//                        onRequest: { request in
//                            request.requestedScopes = [.fullName, .email]
//                        },
//                        onCompletion: viewModel.handleAppleSignIn
//                    )
//                    .signInWithAppleButtonStyle(.black)
//                    .frame(height: 50)
//                    .padding(.horizontal)
//
//                    Spacer()
//                }
                    
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding()
            .animation(.spring(response: 0.35, dampingFraction: 0.85), value: viewModel.isSignedIn)
        }
    }
}

#Preview {
    let container = try! ModelContainer(
        for: UserModel.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )

    let coordinator = AuthCoordinator(
        modelContext: container.mainContext
    )
    let vm = AuthViewModel(authCoordinator: coordinator)

    LoginView(viewModel: vm)
        .modelContainer(container)
}
