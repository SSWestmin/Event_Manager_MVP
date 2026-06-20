////
////  RegRefundForm.swift
////  Event_Manager_Demo
////
////  Created by Sumi Sastri on 24/05/2026.
////
//
//import SwiftUI
//
//// USAGE: Attendee to apply for refund (scale up)
//
//struct RegRefundForm: View {
//    // MARK: - ViewModel - TO DO MOVE TO VM
//    @State private var fullName = ""
//        @State private var email = ""
//        @State private var reason = ""
//        
//        var body: some View {
//            
//            VStack(alignment: .leading, spacing: 20) {
//                
//                // MARK: Top Bar
//                HStack {
//                    
//                    // MARK: Back Button - should show event deleted
//                    Button {
//                    } label: {
//                        Label("Back to registered events", systemImage: "arrow.left")
//                    }
//                    
//                    Spacer()
//                    
//                    // MARK: Logout Button
//                    Button {
//                        // Logout action
//                    } label: {
//                        Label("Logout", systemImage: "person.crop.circle.badge.xmark")
//                    }
//                }
//                .padding(.horizontal)
//                .padding(.top)
//                
//                // MARK: Title
//                Text("Refund Request Form")
//                    .font(.title)
//                    .bold()
//                    .padding(.horizontal)
////                MARK: reusable card with ID
//                // You may need to pass the correct viewModel instance here
//                EventCard(eventID: UUID(), viewModel: EventViewModel())
//                    
//                    TextField("Reason for Refund", text: $reason, axis: .vertical)
//                        .lineLimit(4...6)
//                        .textFieldStyle(.roundedBorder)
//                }
//                .padding(.horizontal)
//                
//                // MARK: Submit Button
//                Button {
//                    // Submit refund request
//                } label: {
//                    Label("Submit Refund Request", systemImage: "arrow.uturn.backward.circle.fill")
//                        .frame(maxWidth: .infinity)
//                }
//                .buttonStyle(.borderedProminent)
//                .padding(.horizontal)
//                
//                Spacer()
//            }
//        
//    }
//
//#Preview {
//    RegRefundForm()
//}
