//
//  ForecastService.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

import Foundation

class ForecastService {
    static let shared = ForecastService()
    
    private init() {}
    
    // Function to fetch forecast data
    func getForecasts() async throws -> Forecast? {
        guard let url = URL(string: Endpoints.Forecast.getForecasts) else {
            throw ForecastError.invalidURL
        }
        
        // Access token from Keychain or UserDefaults
        guard let accessToken = await AuthViewModel().getAccessToken() else {
            throw ForecastError.missingAccessToken
        }
        
        // Set up the headers with Bearer token
        let headers: [String: String] = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        print("headers  \(headers)")
        
        do {
            // Call API using the APIClient and get raw response
            let (data, status) = try await APIClient.shared.request(
                url: url.absoluteString,
                method: "GET",
                body: nil,
                headers: headers
            )
            
            if let rawResponseString = String(data: data, encoding: .utf8) {
                print("Raw Response FORECASTCLIENT: \(rawResponseString)")
                
                // Parse the raw JSON string into a dictionary
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let forecastData = json["data"] as? [[String: Any]], // Assuming the `data` key holds the array
                   let firstForecast = forecastData.first {
                    
                    // Extract the first forecast and manually map it to the Forecast model
                    let forecast = try? mapToForecast(firstForecast)
                    return forecast
                }
            }
            
            // If no forecast data found, throw an error
            throw ForecastError.apiError("Failed to find forecast data in response.")
        } catch {
            throw ForecastError.apiError(error.localizedDescription)
        }
    }
    
    // Manually map the JSON dictionary to the Forecast model
    private func mapToForecast(_ forecastDict: [String: Any]) throws -> Forecast {
        guard let dob = forecastDict["dob"] as? String,
              let address = forecastDict["address"] as? String,
              let pin = forecastDict["pin"] as? Int,
              let district = forecastDict["district"] as? String,
              let state = forecastDict["state"] as? String,
              let email = forecastDict["email"] as? String,
              let id = forecastDict["id"] as? Int,
              let phone = forecastDict["phone"] as? String,
              let name = forecastDict["name"] as? String,
              let locationId = forecastDict["location_id"] as? Int,
              let locationName = forecastDict["location_name"] as? String,
              let gender = forecastDict["gender"] as? String else {
            throw ForecastError.apiError("Invalid or missing data in forecast response.")
        }
        
        return Forecast(
            dob: dob,
            address: address,
            pin: pin,
            district: district,
            state: state,
            email: email,
            id: id,
            phone: phone,
            name: name,
            locationId: locationId,
            locationName: locationName,
            gender: gender
        )
    }
}

// Define the Forecast errors
enum ForecastError: Error, LocalizedError {
    case invalidURL, missingAccessToken, apiError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid API URL."
        case .missingAccessToken:
            return "Missing access token."
        case .apiError(let message):
            return message
        }
    }
}
