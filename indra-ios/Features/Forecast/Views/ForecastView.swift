import SwiftUI

struct ForecastView: View {
    @StateObject private var viewModel = ForecastViewModel()
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        BaseView {
            ScrollView { // Make the whole view scrollable
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Glassmorphic "Today" Forecast Section with Auto-Sized Background
                    ZStack {
                        GlassmorphicBackground()
                            .padding(.horizontal, 16) // Adds spacing from screen edges
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Today")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.leading, 10)
                            
                            // ScrollView wrapped inside the glassmorphic background
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(viewModel.getTodaysForecast()) { forecast in
                                        ForecastVerticalCardView(forecast: forecast)
                                    }
                                }
                                .padding(.leading, 10)
                            }
                        }
                        .padding(16) // Adds padding inside glassmorphic card
                    }
                    .fixedSize(horizontal: false, vertical: true) // Ensures glassmorphic bg only wraps content
                    
                    // TODAY STATS SECTION
                    if let todayStats = viewModel.getTodaysStats() {
                        StatsView(stats: todayStats)
                            .padding(.top, 16)
                        
                    } else {
                        Text("No data available for today's stats")
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Spacer()
                }
                .navigationTitle("Today's Forecast")
                .onAppear {
                    // Ensuring data is loaded when the view appears
                    viewModel.loadDummyData()
                }
            }
        }
    }
}

#Preview {
    ForecastView()
}

// MARK: - Glassmorphic Background
struct GlassmorphicBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.clear) // Fully transparent background
            .background(
                BlurView(style: .regular) // Subtle blur effect for frosted glass look
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.15), lineWidth: 1) // Softer border for visual separation
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
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
