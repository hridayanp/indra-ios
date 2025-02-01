//
//  ForecastView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

// ForecastView.swift

import SwiftUI

struct ForecastView: View {
    @StateObject private var viewModel = ForecastViewModel()
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        BaseView {
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
                                    ForecastVerticalCard(forecast: forecast)
                                }
                            }.padding(.leading, 10)
                        }
                        
                    }
                    .padding(16) // Adds padding inside glassmorphic card
                }
                .fixedSize(horizontal: false, vertical: true) // Ensures glassmorphic bg only wraps content
                
                Spacer()
            }
            .navigationTitle("Today's Forecast")
        }
    }
}

#Preview {
    ForecastView()
}

// MARK: - Glassmorphic Background
//struct GlassmorphicBackground: View {
//    var body: some View {
//        RoundedRectangle(cornerRadius: 8)
//            .fill(Color(hex: "#0B1D29").opacity(0.3)) // Lighter blue transparency
//            .background(
//                BlurView(style: .systemThinMaterial) // Subtle blur effect
//            )
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(Color.white.opacity(0.15), lineWidth: 1) // Softer border
//            )
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//    }
//}

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

// MARK: - Forecast Vertical Card
struct ForecastVerticalCard: View {
    let forecast: Forecast
    
    var body: some View {
        VStack(spacing: 6) {
            Text(getTime(from: forecast.time))
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.8))
            
            Image(systemName: "cloud.fill") // Placeholder icon
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
            
            if let temp = forecast.info.first(where: { $0.type == "temperature" }) {
                Text("\(temp.value)°")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
            }
            
            if let humidity = forecast.info.first(where: { $0.type == "humidity" }) {
                HStack(spacing: 4) {
                    Image(systemName: "drop.fill") // Water droplet icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.cyan)
                    
                    Text("\(humidity.value)%")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                }
            }
            
            if let pressure = forecast.info.first(where: { $0.type == "pressure" }) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left") // "<" icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.gray)
                    
                    Text("\(pressure.value) hPa")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                }
            }
        }
        .frame(width: 61, height: 168)
        .padding(.vertical, 12.5)
        .padding(.horizontal, 6.25)
        .background(Color(hex: "#0B1D29").opacity(0.25)) // Glass-like effect
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white.opacity(0.2), lineWidth: 1.56) // Softer glassmorphic border
        )
    }
}

// MARK: - Helper Functions
func getTime(from dateTime: String) -> String {
    let formatter = ISO8601DateFormatter()
    if let date = formatter.date(from: dateTime) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
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
