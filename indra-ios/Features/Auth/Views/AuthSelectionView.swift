//
//  AuthSelectionView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 31/01/25.
//

import SwiftUI

struct AuthSelectionView: View {
    @StateObject private var authViewModel = AuthViewModel()
    
    @State private var selectedTab: AuthTab = .login
    @State private var screenHeading: String = ""
    
    init(defaultTab: AuthTab) {
        _selectedTab = State(initialValue: defaultTab)
        _screenHeading = State(initialValue: defaultTab == .login ? "Welcome back! Glad to see you again!" : "Welcome to the App! Register your account!")
    }
    
    var body: some View {
        BaseView {
            VStack {
                HStack {
                    Text(screenHeading)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Button(action: {
                        selectedTab = .login
                        screenHeading = "Welcome back! Glad to see you again!"
                        authViewModel.isOtpScreenVisible = false
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(selectedTab == .login ? Color.white : Color.gray.opacity(0))
                            .foregroundColor(selectedTab == .login ? .black : .white)
                            .cornerRadius(8)
                            .foregroundStyle(.white)
                    }
                    
                    Button(action: {
                        selectedTab = .signup
                        screenHeading = authViewModel.isOtpScreenVisible ? "Verify your account" : "Welcome to the App! Register your account!"
                    }) {
                        Text("Signup")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(selectedTab == .signup ? Color.white : Color.gray.opacity(0))
                            .foregroundColor(selectedTab == .signup ? .black : .white)
                            .cornerRadius(8)
                            .foregroundStyle(.white)
                    }
                }
                .padding(4)
                .background(Color(hex: "#787878"))
                .cornerRadius(10)
                .padding(.horizontal)
                
                if selectedTab == .login {
                    LoginView()
                }
                else {
                    SignupView(authViewModel: authViewModel)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    AuthSelectionView(defaultTab: .login)
}
