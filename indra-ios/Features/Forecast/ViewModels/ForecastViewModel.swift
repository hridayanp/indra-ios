import Foundation
import Combine
import KeychainAccess

class ForecastViewModel: ObservableObject {
    @Published var forecasts: [Forecast] = []  // Non-optional array
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    
    private let keychain = Keychain(service: "com.yourapp.service")
    
    let forecastStats: [String: ForecastStats] = [
        "2025/02/03": ForecastStats(
            avgTemperature: "28.46 °C",
            avgHumidity: "73.54 %",
            avgPressure: "1010.54 hPa",
            avgRainfall: "1.95 mm",
            avgWindSpeed: "13.00 km/h",
            weatherCondition: "Heavy_Rain"
        ),
        "2025/02/04": ForecastStats(
            avgTemperature: "27.50 °C",
            avgHumidity: "72.00 %",
            avgPressure: "1012.00 hPa",
            avgRainfall: "3.00 mm",
            avgWindSpeed: "10.00 km/h",
            weatherCondition: "Clear"
        ),
        "2025/02/05": ForecastStats(
            avgTemperature: "29.00 °C",
            avgHumidity: "70.00 %",
            avgPressure: "1011.50 hPa",
            avgRainfall: "0.50 mm",
            avgWindSpeed: "12.00 km/h",
            weatherCondition: "Partly_Cloudy"
        ),
        "2025/02/06": ForecastStats(
            avgTemperature: "30.50 °C",
            avgHumidity: "65.00 %",
            avgPressure: "1013.00 hPa",
            avgRainfall: "0.00 mm",
            avgWindSpeed: "15.00 km/h",
            weatherCondition: "Sunny"
        ),
        "2025/02/07": ForecastStats(
            avgTemperature: "30.50 °C",
            avgHumidity: "65.00 %",
            avgPressure: "1013.00 hPa",
            avgRainfall: "0.00 mm",
            avgWindSpeed: "15.00 km/h",
            weatherCondition: "Sunny"
        ),
        "2025/02/08": ForecastStats(
            avgTemperature: "30.50 °C",
            avgHumidity: "65.00 %",
            avgPressure: "1013.00 hPa",
            avgRainfall: "0.00 mm",
            avgWindSpeed: "15.00 km/h",
            weatherCondition: "Sunny"
        ),
        "2025/02/09": ForecastStats(
            avgTemperature: "30.50 °C",
            avgHumidity: "65.00 %",
            avgPressure: "1013.00 hPa",
            avgRainfall: "0.00 mm",
            avgWindSpeed: "15.00 km/h",
            weatherCondition: "Sunny"
        )
    ]
    
    let forecastData: [ForecastData] = [
        ForecastData(date: "2025/02/03", time: "2025-01-02T00:00:00Z", info: [
            ForecastInfo(type: "temperature", label: "Temperature", value: "29", unit: "°C"),
            ForecastInfo(type: "humidity", label: "Humidity", value: "59", unit: "%"),
            ForecastInfo(type: "pressure", label: "Pressure", value: "1023", unit: "hPa"),
            ForecastInfo(type: "rainfall", label: "Rainfall", value: "1.3", unit: "mm"),
            ForecastInfo(type: "wind_speed", label: "Wind Speed", value: "14", unit: "km/h"),
            ForecastInfo(type: "wind_dir", label: "Wind Direction", value: "SE", unit: "°")
        ]),
        
        ForecastData(date: "2025/02/03", time: "2025-01-02T01:00:00Z", info: [
            ForecastInfo(type: "temperature", label: "Temperature", value: "30", unit: "°C"),
            ForecastInfo(type: "humidity", label: "Humidity", value: "65", unit: "%"),
            ForecastInfo(type: "pressure", label: "Pressure", value: "1024", unit: "hPa"),
            ForecastInfo(type: "rainfall", label: "Rainfall", value: "3.3", unit: "mm"),
            ForecastInfo(type: "wind_speed", label: "Wind Speed", value: "20", unit: "km/h"),
            ForecastInfo(type: "wind_dir", label: "Wind Direction", value: "S", unit: "°")
        ]),
        
        ForecastData(date: "2025/02/03", time: "2025-02-02T02:00:00Z", info: [
            ForecastInfo(type: "temperature", label: "Temperature", value: "27", unit: "°C"),
            ForecastInfo(type: "humidity", label: "Humidity", value: "63", unit: "%"),
            ForecastInfo(type: "pressure", label: "Pressure", value: "1015", unit: "hPa"),
            ForecastInfo(type: "rainfall", label: "Rainfall", value: "1.5", unit: "mm"),
            ForecastInfo(type: "wind_speed", label: "Wind Speed", value: "18", unit: "km/h"),
            ForecastInfo(type: "wind_dir", label: "Wind Direction", value: "NE", unit: "°")
        ]),
        
        ForecastData(date: "2025/02/03", time: "2025-02-02T03:00:00Z", info: [
            ForecastInfo(type: "temperature", label: "Temperature", value: "28", unit: "°C"),
            ForecastInfo(type: "humidity", label: "Humidity", value: "62", unit: "%"),
            ForecastInfo(type: "pressure", label: "Pressure", value: "1016", unit: "hPa"),
            ForecastInfo(type: "rainfall", label: "Rainfall", value: "0.2", unit: "mm"),
            ForecastInfo(type: "wind_speed", label: "Wind Speed", value: "20", unit: "km/h"),
            ForecastInfo(type: "wind_dir", label: "Wind Direction", value: "N", unit: "°")
        ])
    ]
    
    init() {
        loadDummyData()
    }
    
    func loadDummyData() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Create Forecast model by mapping data from forecastData and forecastStats
            let forecasts = self.forecastData.map { data in
                var stats: ForecastStats? = nil
                if let stat = self.forecastStats[data.date] {
                    stats = stat
                }
                
                // Convert time string to Date in UTC
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                formatter.timeZone = TimeZone(abbreviation: "UTC")
                
                // Parse the time string into a Date object
                if let time = formatter.date(from: data.time) {
                    // Format the Date back into a string in UTC (you can adjust this format as needed)
                    let displayFormatter = DateFormatter()
                    displayFormatter.dateFormat = "HH:mm:ss"
                    displayFormatter.timeZone = TimeZone(abbreviation: "UTC")
                    
                    // Update the time string in the forecast data (converted back to UTC)
                    _ = displayFormatter.string(from: time)
                    
                    // Create a Forecast object
                    return Forecast(data: [data], stats: self.forecastStats)
                }
                return Forecast(data: [data], stats: self.forecastStats)
            }
            
            self.forecasts = forecasts
            self.isLoading = false
        }
    }
    
    /// Returns forecast data for the current day
    func getTodaysForecast() -> [Forecast] {
        let todayDate = formatDate(Date()) // Get today’s date as "yyyy/MM/dd"
        return forecasts.filter { $0.data.first?.date == todayDate }
    }
    
    /// Returns stats data for the current day
    func getTodaysStats() -> ForecastStats? {
        let todayDate = formatDate(Date()) // Get today's date as "yyyy/MM/dd"
        
        // Look up today's stats from the forecastStats dictionary
        if let stats = forecastStats[todayDate] {
            return stats
        }
        return nil
    }
    
    func weeklyForecastData(_ data: [String: ForecastStats]) -> [ForecastWeeklySummary] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEEE" // Full day name (e.g., Monday)
        
        // Get today's date as a string
        let todayDateString = dateFormatter.string(from: Date())
        
        // Sort the data keys by date
        let sortedData = data.keys.sorted { (date1, date2) -> Bool in
            guard let dateObj1 = dateFormatter.date(from: date1),
                  let dateObj2 = dateFormatter.date(from: date2) else {
                return false
            }
            return dateObj1 < dateObj2
        }
        
        return sortedData.compactMap { (dateString) -> ForecastWeeklySummary? in
            guard let stats = data[dateString] else { return nil }
            
            let dayName = (dateString == todayDateString) ? "Today" : dayFormatter.string(from: dateFormatter.date(from: dateString)!)
            
            return ForecastWeeklySummary(
                date: dateString,
                day: dayName,
                avgTemperature: stats.avgTemperature,
                avgHumidity: stats.avgHumidity
            )
        }
    }
    
    /// Helper function to format Date as "YYYY/MM/DD"
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date)
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
