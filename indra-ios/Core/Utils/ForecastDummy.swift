//
//  ForecastDummy.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

import Foundation

struct ForecastDummyData {
    
    static let sampleForecasts: [Forecast] = generateForecasts()
    
    static func generateForecasts() -> [Forecast] {
        var forecasts: [Forecast] = []
        let calendar = Calendar.current
        let startDate = createDate(year: 2025, month: 1, day: 31, hour: 0) // Start: Jan 31, 2025, 00:00
        let endDate = createDate(year: 2025, month: 2, day: 6, hour: 23)  // End: Feb 6, 2025, 23:00
        
        var currentDate = startDate
        
        while currentDate <= endDate {
            let formattedDate = formatDate(currentDate)
            let formattedTime = formatISOTime(currentDate)
            
            let forecast = Forecast(
                date: formattedDate,
                time: formattedTime,
                info: generateForecastInfo()
            )
            
            forecasts.append(forecast)
            
            // Move to the next hour
            if let nextHour = calendar.date(byAdding: .hour, value: 1, to: currentDate) {
                currentDate = nextHour
            } else {
                break
            }
        }
        
        return forecasts
    }
    
    /// Generates random forecast info
    private static func generateForecastInfo() -> [ForecastInfo] {
        return [
            ForecastInfo(type: "temperature", label: "Temperature", value: "\(Int.random(in: 25...40))", unit: "°C"),
            ForecastInfo(type: "humidity", label: "Humidity", value: "\(Int.random(in: 40...80))", unit: "%"),
            ForecastInfo(type: "pressure", label: "Pressure", value: "\(Int.random(in: 1000...1030))", unit: "hPa")
        ]
    }
    
    /// Creates a Date object from given components
    private static func createDate(year: Int, month: Int, day: Int, hour: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = 0
        components.second = 0
        
        return Calendar.current.date(from: components) ?? Date()
    }
    
    /// Formats date as "YYYY/MM/DD"
    private static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date)
    }
    
    /// Formats time as "YYYY-MM-DDTHH:mm:ssZ" (ISO 8601)
    private static func formatISOTime(_ date: Date) -> String {
        let formatter = ISO8601DateFormatter()
        return formatter.string(from: date)
    }
}
