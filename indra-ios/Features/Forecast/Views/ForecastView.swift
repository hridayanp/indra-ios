import SwiftUI

struct ForecastView: View {
    @StateObject private var viewModel = ForecastViewModel()
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        BaseView(weatherCondition: viewModel.getTodaysStats()?.weatherCondition) {
            ScrollView(showsIndicators: false) {
                if let todayStats = viewModel.getTodaysStats() {
                    VStack(spacing: 10) {
                        
                        Text(todayStats.avgTemperature)
                            .font(.system(size: 70, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text(todayStats.weatherCondition.replacingOccurrences(of: "_", with: " "))
                            .font(.system(size: 24, weight: .regular))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        
                        HStack {
                            Text("\(todayStats.avgRainfall)")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("\(todayStats.avgWindSpeed)")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: 200)
                    }
                    .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.2)
                    .background(Color.clear)
                    
                    
                } else {
                    Text("No data available for today's stats")
                        .foregroundColor(.white)
                        .padding()
                }
                
                
                ZStack {
                    GlassmorphicBackground()
                        .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Today")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            if !viewModel.getTodaysForecast().isEmpty {
                                HStack(spacing: 10) {
                                    ForEach(viewModel.getTodaysForecast()) { forecast in
                                        ForecastVerticalCardView(forecast: forecast)
                                    }
                                }
                                .padding(.leading, 10)
                            } else {
                                // Display fallback message if the forecast is empty
                                Text("No Data Available for Today's Forecast")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .padding(.leading, 10)
                            }
                        }
                    }
                    .padding(16)
                }
                .fixedSize(horizontal: false, vertical: true)

                if let todayStats = viewModel.getTodaysStats() {
                    StatsView(stats: todayStats)
                } else {
                    Text("No data available for today's stats")
                        .foregroundColor(.white)
                        .padding()
                }
                
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 10)
            
        }
        
        .onAppear {
            viewModel.loadDummyData()
        }
        
    }
        
        
}




#Preview {
    ForecastView()
}


// MARK: - Helper Functions
func getTime(from dateTime: String) -> String {
    let formatter = ISO8601DateFormatter()
    
    // Set the timeZone to UTC
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    
    if let date = formatter.date(from: dateTime) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        // Ensure the timeFormatter uses UTC for formatting as well
        timeFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return timeFormatter.string(from: date)
    }
    return "N/A"
}
// MARK: - Blur View (For Glassmorphism)
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
