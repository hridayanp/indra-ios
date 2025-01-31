//
//  AuthService.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 31/01/25.
//

import Foundation

class AuthService {
    static let shared = AuthService()
    
    func login(email: String, password: String) async throws -> User {
        return User(email: email, password: password)
    }
}

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
