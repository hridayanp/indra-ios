//
//  LoginView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 31/01/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        BaseView {
            VStack(spacing: 16) {
                Text("Login to your account")
                    .font(.title)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                CustomTextField(placeholder: "Email", text: $email, keyboardType: .emailAddress)
                CustomTextField(placeholder: "Password", text: $password, isSecureTextEntry: true)
                
                Spacer()
                
                CustomButton(title: "Login", type: .primary) {
                    print("Pressed")
                }
                
                
            }.padding()
        }
        
    }
}

//#Preview {
//    LoginView()
//}
