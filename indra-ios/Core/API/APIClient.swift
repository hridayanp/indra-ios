//  APIClient.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

import Foundation

class APIClient {
    static let shared = APIClient()
    
    private init() {}
    
    // Updated request method to return raw response data directly from the API
    func request(
        url: String,
        method: String,
        body: [String: Any]?,
        headers: [String: String] = ["Content-Type": "application/json"]
    ) async throws -> (data: Data, status: Int) {
        
        guard let requestURL = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        
        // If the body exists, convert it into JSON and assign it to the request body
        if let body = body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        
        print("Request BODY: \(String(describing: body))")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Print raw response for debugging
//        if let rawResponseString = String(data: data, encoding: .utf8) {
//            print("Raw Response APICLIENT: \(rawResponseString)")
//        }
        
        // Check if the response status code is 200 OK, else throw an error
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        // Return raw data and status code
        return (data, httpResponse.statusCode)
    }
}

// Enum for API Errors
enum APIError: Error, LocalizedError {
    case invalidURL, invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid API URL."
        case .invalidResponse:
            return "Invalid response from server."
        }
    }
}
