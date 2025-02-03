//
//  ChangePasswordView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 03/02/25.
//

import SwiftUI

struct ChangePasswordView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentPassword: String = ""
    
    // Navigation state
    @State private var navigateToNewPasswordView = false
    
    @Binding var isInDetailView: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#0B1D29")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Enter your current password")
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                    
                    CustomTextField(placeholder: "Enter Current Password", text: $currentPassword, keyboardType: .default, isEditable: true)
                    
                    Spacer()
                    
                    CustomButton(
                        title: "Proceed",
                        type: .primary,
                        action: {
                            // Trigger navigation to the new password view
                            navigateToNewPasswordView = true
                        },
                        isDisabled: false, //currentPassword.isEmpty,
                        isLoading: false
                    )
                    .padding(.top, 20)
                    
                    // Handle navigation to NewPasswordView
                    .navigationDestination(isPresented: $navigateToNewPasswordView) {
                        NewPasswordView(isInDetailView: $isInDetailView)
                    }
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "arrow.left.circle.fill") // Left arrow icon
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        }
                        
                        Text("Current Password")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
            }
            .onAppear {
                isInDetailView = true // Hide toolbar from MenuView
            }
            .onDisappear {
                isInDetailView = false // Show toolbar again when exiting NewsDetailView
            }
        }
    }
}

struct NewPasswordView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    
    @Binding var isInDetailView: Bool
    
    var body: some View {
        ZStack {
            Color(hex: "#0B1D29")
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text("Set your password")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                    .padding(.top, 10)
                
                CustomTextField(placeholder: "New Password", text: $newPassword, keyboardType: .default, isEditable: true)
                
                CustomTextField(placeholder: "Confirm Password", text: $confirmPassword, keyboardType: .default, isEditable: true)
                
                Spacer()
                
                CustomButton(
                    title: "Change Password",
                    type: .primary,
                    action: {
                        if newPassword == confirmPassword {
                            print("Password Changed: \(newPassword)")
                        } else {
                            print("Passwords do not match")
                        }
                    },
                    isDisabled: newPassword.isEmpty || confirmPassword.isEmpty || newPassword != confirmPassword,
                    isLoading: false
                )
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left.circle.fill") // Left arrow icon
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    
                    Text("Change Password")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            isInDetailView = true // Hide toolbar from MenuView
        }
        .onDisappear {
            isInDetailView = false // Show toolbar again when exiting NewsDetailView
        }
    }
}

#Preview {
    ChangePasswordView(isInDetailView: .constant(false))
}
