//
//  LoginView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 31/01/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = "hridayan@misteo.co"
    @State private var password: String = "gf@jhfYOZ#ger"
    
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        BaseView {
            VStack(spacing: 16) {
                Text("Login to your account")
                    .font(.title)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                CustomTextField(placeholder: "Email", text: $email, keyboardType: .emailAddress)
                CustomTextField(placeholder: "Password", text: $password, isSecureTextEntry: true)
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.system(size: 18, weight: .bold))
                }
                
                
                
                Spacer()
                
                CustomButton(
                    title: "Login",
                    type: .primary,
                    action: {
                        Task {
                            await viewModel.login(email: email, password: password)
                        }
                    },
                    isDisabled: email.isEmpty || password.isEmpty,
                    isLoading: viewModel.isLoading
                )
                
            }.padding()
        }
        
    }
}

#Preview {
    LoginView()
}
