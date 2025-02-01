//
//  ForecastViewModel.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

import Foundation
import Combine

class ForecastViewModel: ObservableObject {
    @Published var forecasts: [Forecast] = []  // Non-optional array
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    
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
}
