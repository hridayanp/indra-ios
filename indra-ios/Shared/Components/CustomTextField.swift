//
//  CustomTextField.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 31/01/25.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    var text: Binding<String>
    var isSecureTextEntry: Bool = false
    var keyboardType: UIKeyboardType = .default
    var isEditable: Bool = true
    
    var body: some View {
        VStack {
           
            
            if isSecureTextEntry {
                SecureField(placeholder, text: text)
                    .padding()
                    .frame(height: 56)
                    .background(Color(hex: "#5B5B5B"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .keyboardType(keyboardType)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .placeholder(when: text.wrappedValue.isEmpty) {
                        Text(placeholder)
                            .foregroundColor(Color(.white))
                            .padding()
                    }
            } else {
                TextField(placeholder, text: text)
                    .padding()
                    .frame(height: 56)
                    .background(Color(hex: "#5B5B5B"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .keyboardType(keyboardType)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .disabled(!isEditable)
                    .opacity(isEditable ? 1.0 : 0.6)
                    .placeholder(when: text.wrappedValue.isEmpty) {
                        Text(placeholder)
                            .foregroundColor(Color(.white))
                            .padding()
                    }
            }
        }
    }
}

extension View {
    // Custom modifier to display the placeholder when the text is empty
    func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder content: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            self
            if shouldShow {
                content()
            }
        }
    }
}
