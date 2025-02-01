//
//  AuthService.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 31/01/25.
//

import Foundation

class AuthService {
    static let shared = AuthService()
    
    private init() {} // Enforce singleton pattern
    
    func login(email: String, password: String) async throws -> User {
        guard let url = URL(string: Endpoints.Auth.login) else {
            throw AuthError.invalidURL
        }
        print("AUTH SERVICE URL: \(url)")
        
        // Prepare the request body
        let requestBody: [String: Any] = [
            "username": email,
            "password": password
        ]
        
        do {
            // Make API request using APIClient
            let (data, status) = try await APIClient.shared.request(
                url: url.absoluteString,
                method: "POST",
                body: requestBody
            )
            
            // Print the raw response for debugging
//            if let rawResponseString = String(data: data, encoding: .utf8) {
//                print("Raw Response: \(rawResponseString)")
//            }
            
            // Check if the status is 200 and handle the data directly
            if status == 200 {
                // Decode the response directly into UserData
                do {
                    let userData = try JSONDecoder().decode(UserData.self, from: data)
                    
                    // Successfully decoded, return User object
                    return User(
                        userId: userData.user_id,
                        email: userData.email,
                        username: userData.username,
                        role: userData.role,
                        roleName: userData.role_name,
                        accessToken: userData.access,
                        refreshToken: userData.refresh
                    )
                } catch {
                    // Handle decoding error if necessary
                    print("Decoding error: \(error)")
                    throw AuthError.invalidCredentials
                }
            } else {
                throw AuthError.invalidCredentials
            }
            
        } catch {
            print("INSIDE AUTH ERROR: \(error)")
            throw AuthError.invalidCredentials
        }
    }
}

// MARK: - API Response Model
struct UserData: Decodable {
    let user_id: Int
    let email: String
    let username: String
    let role: Int
    let role_name: String
    let access: String
    let refresh: String
}

// MARK: - Authentication Errors
enum AuthError: Error, LocalizedError {
    case invalidURL, invalidCredentials
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid API URL."
        case .invalidCredentials:
            return "Incorrect email or password."
        }
    }
}
