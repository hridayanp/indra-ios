//
//  ForecastViewModel.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

import Foundation
import Combine
import KeychainAccess

class ForecastViewModel: ObservableObject {
    @Published var forecasts: [Forecast] = []  // Non-optional array
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    
    private let keychain = Keychain(service: "com.yourapp.service")
    
    // Fetch forecasts from service
    func fetchForecasts() async {
        do {
            // Assuming ForecastService fetches data correctly
            if let forecast = try await ForecastService.shared.getForecasts() {
                self.forecasts = [forecast] // Wrap the forecast in an array
            } else {
                self.forecasts = []
            }
            self.isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
    
    // Logout function to remove user data from Keychain and notify the UI to go back to the login screen
    func logout() {
        // Clear user data from Keychain
        do {
            try keychain.remove("accessToken") // Adjust key name as per your Keychain data
        } catch {
            print("Error removing access token from Keychain: \(error.localizedDescription)")
        }
        
        // You can clear any other user-related data as needed (e.g., user ID, etc.)
        // Notify that the user has logged out
        self.forecasts = [] // Optionally clear forecasts after logout
    }
}
