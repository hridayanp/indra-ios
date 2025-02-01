//
//  ForecastVerticalCardView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

import SwiftUI

// MARK: - Forecast Vertical Card
struct ForecastVerticalCardView: View {
    let forecast: Forecast
    
    var body: some View {
        VStack(spacing: 6) {
            Text(getTime(from: forecast.data.first?.time ?? ""))
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.8))
            
            Image(systemName: "cloud.fill") // Placeholder icon
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
            
            if let temp = forecast.data.first?.info.first(where: { $0.type == "temperature" }) {
                Text("\(temp.value)°")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
            }
            
            if let rainfall = forecast.data.first?.info.first(where: { $0.type == "rainfall" }) {
                HStack(spacing: 4) {
                    Image(systemName: "drop.fill") // "<" icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.gray)
                    
                    Text("\(rainfall.value) mm")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                }
            }
            
            if let humidity = forecast.data.first?.info.first(where: { $0.type == "humidity" }) {
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
            
            if let pressure = forecast.data.first?.info.first(where: { $0.type == "pressure" }) {
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
