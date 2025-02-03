//
//  Forecast.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

import Foundation

// Forecast will include both 'data' and 'stats'
struct Forecast: Identifiable {
    let id = UUID() // Unique identifier
    let data: [ForecastData]
    let stats: [String: ForecastStats]
}

// ForecastData will represent a specific forecast object with date, time, and info
struct ForecastData: Identifiable {
    let id = UUID() // Unique identifier
    let date: String
    let time: String
    let info: [ForecastInfo] // Information about the forecast for the given date/time
}

// ForecastStats will represent the statistics for a particular date (avg temperature, humidity, etc.)
struct ForecastStats: Codable {
    let avgTemperature: String
    let avgHumidity: String
    let avgPressure: String
    let avgRainfall: String
    let avgWindSpeed: String
    let weatherCondition: String
}

// ForecastInfo will hold individual forecast information (like temperature, humidity, etc.)
struct ForecastInfo {
    let type: String
    let label: String
    let value: String
    let unit: String
}

struct ForecastWeeklySummary: Identifiable {
    let id = UUID() // Unique identifier
    let date: String
    let day: String
    let avgTemperature: String
    let avgHumidity: String
}
