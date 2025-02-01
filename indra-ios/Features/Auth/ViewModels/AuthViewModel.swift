//
//  AuthViewModel.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 31/01/25.
//

import Foundation
import Security

@MainActor
class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var user: User?
    @Published var isOtpScreenVisible: Bool = false // Global state to control OTP screen visibility
    @Published var otp: String = ""
    
    // Published property to track login success
    @Published var isLoggedIn: Bool = false
    
    var router: AppRouter?
    
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
//            let user = try await AuthService.shared.login(email: email, password: password)
//            self.user = user
//            print("Logged IN: \(user)")
//            
//            // Store the user's access token in the Keychain
//            storeAccessToken(user.accessToken)
//            
//            // Store user details in UserDefaults
//            storeUserDetails(user)
            isLoggedIn = true  // Set to true when login is successful
            
            
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
    
    // Store access token in Keychain
    private func storeAccessToken(_ accessToken: String) {
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "access_token",  // Account name
            kSecValueData as String: accessToken.data(using: .utf8) ?? Data()
        ]
        
        // Delete existing access token if it exists
        SecItemDelete(keychainQuery as CFDictionary)
        
        // Add new access token to the Keychain
        let status = SecItemAdd(keychainQuery as CFDictionary, nil)
        
        if status != errSecSuccess {
            print("Failed to store access token: \(status)")
        }
    }
    
    // Retrieve access token from Keychain
    func getAccessToken() -> String? {
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "access_token", // Account name
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(keychainQuery as CFDictionary, &item)
        
        if status == errSecSuccess, let data = item as? Data, let accessToken = String(data: data, encoding: .utf8) {
            return accessToken
        } else {
            print("Failed to retrieve access token: \(status)")
            return nil
        }
    }
    
    // Store user details in UserDefaults
    private func storeUserDetails(_ user: User) {
        let defaults = UserDefaults.standard
        defaults.set(user.userId, forKey: "userId")
        defaults.set(user.email, forKey: "email")
        defaults.set(user.username, forKey: "username")
        defaults.set(user.role, forKey: "role")
        defaults.set(user.roleName, forKey: "roleName")
        defaults.set(user.accessToken, forKey: "accessToken")
        defaults.set(user.refreshToken, forKey: "refreshToken")
    }
    
    // Retrieve user details from UserDefaults
    func getUserDetails() -> User? {
        let defaults = UserDefaults.standard
        guard let userId = defaults.value(forKey: "userId") as? Int,
              let email = defaults.value(forKey: "email") as? String,
              let username = defaults.value(forKey: "username") as? String,
              let role = defaults.value(forKey: "role") as? Int,
              let roleName = defaults.value(forKey: "roleName") as? String,
              let accessToken = defaults.value(forKey: "accessToken") as? String,
              let refreshToken = defaults.value(forKey: "refreshToken") as? String else {
            return nil
        }
        
        return User(
            userId: userId,
            email: email,
            username: username,
            role: role,
            roleName: roleName,
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }
}
