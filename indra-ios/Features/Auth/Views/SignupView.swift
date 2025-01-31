//
//  SignupView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 31/01/25.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var authViewModel: AuthViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var confirmPassword: String = ""
    @State private var isAgreed: Bool = false
    
    var body: some View {
        BaseView {
            VStack(spacing: 16) {
                if !authViewModel.isOtpScreenVisible { // Show this when OTP screen is not visible
                    Text("Create your account")
                        .font(.title)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomTextField(placeholder: "First Name", text: $firstName)
                    CustomTextField(placeholder: "Last Name", text: $lastName)
                    CustomTextField(placeholder: "Email", text: $email, keyboardType: .emailAddress)
                    CustomTextField(placeholder: "Password", text: $password, isSecureTextEntry: true)
                    CustomTextField(placeholder: "Confirm Password", text: $confirmPassword, isSecureTextEntry: true)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            isAgreed.toggle()
                        }) {
                            HStack {
                                Image(systemName: isAgreed ? "checkmark.square" : "square")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(isAgreed ? .white : .gray) // Color based on state
                                
                                Text("I agree to all user agreement and privacy policy.")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.subheadline)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomButton(title: "Send Code", type: .primary) {
                        // Show OTP screen when Send Code is pressed
                        authViewModel.isOtpScreenVisible = true
                    }
                } else {
                    // OTP View will be shown here when Send Code is clicked
                    OTPView(otp: $authViewModel.otp)
                }
                
                
            }.padding()
        }
    }
}
