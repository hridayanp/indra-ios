import SwiftUI

// MARK: - Today Stats View
struct StatsView: View {
    let stats: ForecastStats
    
    // A dictionary to map the stat fields to display titles and icons
    private let statTitles: [String: (String, String)] = [
        "weatherCondition": ("cloud.sun", "Weather Condition"),
        "avgTemperature": ("thermometer", "Avg. Temperature"),
        "avgHumidity": ("humidity", "Avg. Humidity"),
        "avgPressure": ("gauge", "Avg. Pressure"),
        "avgRainfall": ("cloud.rain", "Avg. Rainfall"),
        "avgWindSpeed": ("wind", "Avg. Wind Speed")
    ]
    
    // Helper function to format the Weather Condition value (remove underscores)
    private func formatWeatherCondition(_ condition: String) -> String {
        return condition.replacingOccurrences(of: "_", with: " ")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Dynamically creating rows based on the available stats
            let statKeys = Array(statTitles.keys)
            
            ForEach(0..<statKeys.count / 2 + statKeys.count % 2, id: \.self) { rowIndex in
                HStack(spacing: 16) {
                    ForEach(0..<2, id: \.self) { index in
                        let statKeyIndex = rowIndex * 2 + index
                        guard statKeyIndex < statKeys.count else { return AnyView(EmptyView()) }
                        
                        let statKey = statKeys[statKeyIndex]
                        let (icon, title) = statTitles[statKey]!
                        
                        // Determine the stat value dynamically
                        let value: String
                        switch statKey {
                        case "weatherCondition":
                            value = formatWeatherCondition(stats.weatherCondition)
                        case "avgTemperature":
                            value = stats.avgTemperature
                        case "avgHumidity":
                            value = stats.avgHumidity
                        case "avgPressure":
                            value = stats.avgPressure
                        case "avgRainfall":
                            value = stats.avgRainfall
                        case "avgWindSpeed":
                            value = stats.avgWindSpeed
                        default:
                            value = "N/A"
                        }
                        
                        return AnyView(
                            StatCard(
                                icon: icon,
                                title: title,
                                value: value
                            )
                        )
                    }
                }
            }
        }
        //.background(Color(hex: "#3A61AD")) // Card background color
//        .background(
//            BlurView(style: .regular)
//                .cornerRadius(12)
//                .opacity(0.2)
//        )
        .padding()
    }
}

//// MARK: - Stat Card View
//struct StatCard: View {
//    let icon: String
//    let title: String
//    let value: String
//    
//    var body: some View {
//        VStack {
//            
//            
//            // Parameter title and value
//            VStack(spacing: 8) {
//                // Icon at the top
//                Image(systemName: icon)
//                    .font(.system(size: 24)) // Decrease icon size
//                    .foregroundColor(.white)
//                    .padding(8)
//                
//                // Parameter name (Title)
//                Text(title)
//                    .font(.system(size: 15)) // Decrease font size for title
//                    .fontWeight(.regular)
//                    .lineSpacing(2)
//                    .foregroundColor(.white)
//                
//                
//            }
//            
//            // Parameter value
//            Text(value)
//                .font(.system(size: 18, weight: .medium, design: .default)) // Decrease font size for value
//                .foregroundColor(.white)
//                .padding(.vertical, 6)
//                .frame(maxWidth: .infinity)
//                .background(Color.clear)
//        }
//        .frame(maxWidth: .infinity, minHeight: 100) // Set a fixed height for the card
//        .background(Color.clear) // No background for card
//        .cornerRadius(8)
//        .overlay(
//            RoundedRectangle(cornerRadius: 8)
//                .stroke(Color(hex: "#EEEEEE"), lineWidth: 0.5) // Border color
//        )
//        
//    }
//}

// MARK: - Stat Card View
struct StatCard: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            // Parameter title and value
            VStack(spacing: 8) {
                // Icon at the top
                Image(systemName: icon)
                    .font(.system(size: 24)) // Decrease icon size
                    .foregroundColor(.white)
                    .padding(8)
                
                // Parameter name (Title)
                Text(title)
                    .font(.system(size: 15)) // Decrease font size for title
                    .fontWeight(.regular)
                    .lineSpacing(2)
                    .foregroundColor(.white)
            }
            
            // Parameter value
            Text(value)
                .font(.system(size: 18, weight: .medium, design: .default)) // Decrease font size for value
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity)
                .background(Color.clear)
        }
        .frame(maxWidth: .infinity, minHeight: 100) // Set a fixed height for the card
        .background(
            GlassmorphicBackground() // Apply the Glassmorphic background to each card
        )
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: "#EEEEEE"), lineWidth: 0.5) // Border color
        )
    }
}

#Preview {
    StatsView(stats: ForecastStats(
        avgTemperature: "28.46 °C",
        avgHumidity: "73.54 %",
        avgPressure: "1010.54 hPa",
        avgRainfall: "1.95 mm",
        avgWindSpeed: "13.00 km/h",
        weatherCondition: "Heavy_Rain"
    ))
}
