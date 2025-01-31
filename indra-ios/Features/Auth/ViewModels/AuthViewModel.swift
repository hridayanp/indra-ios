//
//  AuthViewModel.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 31/01/25.
//

import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var user: User?
    @Published var isOtpScreenVisible: Bool = false // Global state to control OTP screen visibility
    @Published var otp: String = ""
    
    func login() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let user = try await AuthService.shared.login(email: email, password: password)
            self.user = user
            print("Logged IN: \(user.email)")
            isLoading = false
        }
        catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
        
    }
}
