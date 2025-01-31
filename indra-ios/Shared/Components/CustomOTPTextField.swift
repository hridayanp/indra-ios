//
//  CustomOTPTextField.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//


import SwiftUI

struct CustomOTPTextField: View {
    
    let numberOfField: Int
    @FocusState private var fieldFocus: Int?
    @State var enterValue: [String]
    @State var oldValue = ""
    @Binding var otp: String
    
    init(numberOfField: Int, otp: Binding<String>) {
        self.numberOfField = numberOfField
        self.enterValue = Array(repeating: "", count: numberOfField)
        self._otp = otp
    }
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<numberOfField, id: \.self) { index in
                TextField("", text: $enterValue[index]) { editing in
                    if editing {
                        oldValue = enterValue[index]
                    }
                }
                .keyboardType(.numberPad)
                .frame(width: 65, height: 65)
                .font(.system(size: 25, weight: .medium))
                .background(Color(hex: "#5B5B5B"))  // Matching background color
                .foregroundColor(.white)  // White text color
                .accentColor(.clear)  // Disable cursor color
                .multilineTextAlignment(.center)
                .focused($fieldFocus, equals: index)
                .tag(index)
                .textContentType(.oneTimeCode)
                .onChange(of: enterValue[index]) { oldValue, newValue in
                    
                    let currentValue = newValue
                    
                    // Ensure the entered value does not exceed the field's limit
                    if currentValue.count > 1 && currentValue.count <= numberOfField {
                        var i = index
                        for otpNumber in currentValue {
                            enterValue[i] = String(otpNumber)
                            if (numberOfField - 1 > i) {
                                i += 1
                            }
                            fieldFocus = (fieldFocus ?? 0) + 1
                        }
                        updateOTPString()
                    }
                    
                    // Handle single character input from numpad keyboard
                    else {
                        if !currentValue.isEmpty {
                            if enterValue[index].count > 1 {
                                let currentValue = Array(enterValue[index])
                                
                                if let oldValueFirstCharacter = oldValue.first {
                                    if currentValue[0] == Character(extendedGraphemeClusterLiteral: oldValueFirstCharacter) {
                                        enterValue[index] = String(enterValue[index].suffix(1))
                                    } else {
                                        enterValue[index] = String(enterValue[index].prefix(1))
                                    }
                                }
                            }
                            
                            // Move focus to the next field
                            if index == numberOfField - 1 {
                                fieldFocus = nil
                            } else {
                                fieldFocus = (fieldFocus ?? 0) + 1
                            }
                        } else {
                            // Move focus to the previous field
                            fieldFocus = (fieldFocus ?? 0) - 1
                        }
                        updateOTPString()
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(fieldFocus == index ? Color.white : Color.clear, lineWidth: 4)
                )
                .cornerRadius(8)
            }
        }
    }
    
    private func updateOTPString() {
        otp = enterValue.joined()
    }
}

//struct OTPInput_Previews: PreviewProvider {
//    static var previews: some View {
//        @State var otp = ""
//        return CustomOTPTextField(numberOfField: 4, otp: $otp)
//    }
//}
