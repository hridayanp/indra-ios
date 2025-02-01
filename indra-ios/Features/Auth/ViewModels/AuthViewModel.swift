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
    
    func login(email: String, password: String) async {
        // Validate email before proceeding
        guard isValidEmail(email) else {
            DispatchQueue.main.async {
                self.errorMessage = "Invalid email"
            }
            return
        }
        isLoading = true
        errorMessage = nil
        
        // Introduce a 3-second delay
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        
        do {
            let user = try await AuthService.shared.login(email: email, password: password)
            self.user = user
            print("Logged IN: \(user)")
            isLoading = false
        }
        catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
        
    }
    
    
    // Email validation function
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
