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
    
    // MARK: Role allocation and navigation fork
    let eventViewModel: EventViewModel
    let adminViewModel: AdminViewModel
    @ViewBuilder
    private var signedInDestination: some View {
        if viewModel.signedInRole == .admin {
            AdminDashboard(viewModel: adminViewModel)
        } else {
            AttendeeDashboard(viewModel: eventViewModel)
        }
    }

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
                            viewModel.mockAppleSignIn(
                                email: "admin@eventrabbit.demo",
                                name: "Admin User"
                            )
                        } label: {
                            Text("Demo Admin Sign In")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }

                        Button {
                            viewModel.mockAppleSignIn(
                                email: "attendee@eventrabbit.demo",
                                name: "Attendee User"
                            )
                        } label: {
                            Text("Demo Attendee Sign In")
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
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding()
            .animation(.spring(response: 0.35, dampingFraction: 0.85), value: viewModel.isSignedIn)
        }
        .navigationDestination(isPresented: Binding(
            get: { viewModel.isSignedIn && viewModel.signedInRole != nil },
            set: { isPresented in
                if !isPresented {
                    viewModel.isSignedIn = false
//                    MARK: Fork in navigation refactor for admin VM
                    viewModel.signedInRole = nil
                    eventViewModel.currentUserRole = nil
                    adminViewModel.currentUserRole = nil
                }
            }
        )) {
            signedInDestination
        }
        .onChange(of: viewModel.signedInRole) { _, newRole in
            eventViewModel.currentUserRole = newRole?.rawValue
            adminViewModel.currentUserRole = newRole?.rawValue
        }
    }
}
//                    MARK: Fork in navigation refactor for admin VM
#Preview {
    let container = try! ModelContainer(
        for: UserModel.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )

    let coordinator = AuthCoordinator(
        modelContext: container.mainContext
    )
    let vm = AuthViewModel(authCoordinator: coordinator)
    let eventCoordinator = EventDataCoordinator(modelContext: container.mainContext)
    let eventVM = EventViewModel(coordinator: eventCoordinator)
    let adminVM = AdminViewModel(coordinator: eventCoordinator)

    LoginView(viewModel: vm, eventViewModel: eventVM, adminViewModel: adminVM)
        .environmentObject(eventCoordinator)
        .modelContainer(container)
}
