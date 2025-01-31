//
//  CustomButton.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 31/01/25.
//

import SwiftUI

enum ButtonType {
    case primary, secondary
}

struct CustomButton: View {
    var title: String
    var type: ButtonType
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(type == .primary ? Color.white : Color.clear) // Primary: White bg, Secondary: Transparent
                .foregroundColor(type == .primary ? Color.black : Color.white) // Primary: Black text, Secondary: White text
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 2) // White border for both types
                )
                .cornerRadius(8)
        }
    }
}
