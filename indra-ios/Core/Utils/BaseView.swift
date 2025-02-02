import SwiftUI

struct BaseView<Content: View>: View {
    var content: Content
    var weatherCondition: String?
    
    init(weatherCondition: String? = nil, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.weatherCondition = weatherCondition
    }
    
    var body: some View {
        ZStack {
            // Background Image based on Weather Condition & Day/Night
            if let condition = weatherCondition {
                Image(getBackgroundImage(for: condition))
                    .resizable()
                    .edgesIgnoringSafeArea(.all) // Makes sure the image covers the full screen
                    .zIndex(0) // Ensures the background is at the bottom
            } else {
                Color(hex: "#0B1D29") // Default background
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(0)
            }
            
            content
            
        }
    }
    
    /// Determines background image based on weather condition & time of day
    private func getBackgroundImage(for condition: String) -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        let isNight = hour < 6 || hour >= 18 // Night time (before 6 AM or after 6 PM)
        
        let conditionKey = condition.lowercased().replacingOccurrences(of: "_", with: " ")
        
        switch conditionKey {
        case "clear sky":
            return isNight ? "clear-night" : "sunny-day"
        case "few clouds", "scattered clouds", "broken clouds", "partly cloudy":
            return isNight ? "partly-clear-night" : "partly-cloudy-day"
        case "shower rain", "rain", "light rain", "moderate rain", "heavy rain":
            return isNight ? "rain-night" : "rain-day"
        case "thunderstorm":
            return !isNight ? "thunderstorm-night" : "thunderstorm-day"
        case "snow":
            return isNight ? "snowy-night" : "snowy-day"
        case "mist", "fog":
            return isNight ? "clear-night" : "cloudy-day"
        case "overcast clouds":
            return "cloudy-day"
        case "mostly sunny":
            return "mostly-sunny-day"
        default:
            return isNight ? "clear-night" : "cloudy-day"
        }
    }
    
    // Get top safe area padding for the current window scene (works for iOS 15+)
    private func getSafeAreaTopPadding() -> CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                return window.safeAreaInsets.top
            }
        }
        return 0
    }
}

#Preview {
    BaseView(weatherCondition: "thunderstorm") {
        ScrollView {
            VStack(spacing: 10) {
                
                Text("todayStats.avgTemperature")
                    .font(.system(size: 70, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Text("Text")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                HStack {
                    Text("todayStats.avgRainfall")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("todayStats.avgWindSpeed")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 200)
            }
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.3)
            .background(Color.clear)
            .padding(.horizontal, 16)
        }
    }
}
