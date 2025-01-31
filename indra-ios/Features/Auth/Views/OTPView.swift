//
//  OTPView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 31/01/25.
//

import SwiftUI

struct OTPView: View {
    @Binding var otp: String
    @State private var isOtpVerified = false // Track if OTP is verified
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Enter OTP")
                .font(.title)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 12) {
//                ForEach(0..<4, id: \.self) { index in
//                    CustomOTPTextField(otp: $otp, index: index)
//                        .frame(width: 65, height: 65)
//                        .keyboardType(.numberPad)
//                }
                
                CustomOTPTextField(numberOfField: 4, otp: $otp)
            }
            
            CustomButton(title: "Verify", type: .primary) {
                // Handle OTP verification
                if otp.count == 4 {
                    print("OTP Entered: \(otp)")
                    // You can perform your OTP verification logic here
                    isOtpVerified = true
                }
            }
            
            Spacer()
        }
    }
}
