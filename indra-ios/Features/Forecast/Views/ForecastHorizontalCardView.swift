//
//  ForecastHorizontalCardView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 03/02/25.
//

import SwiftUI

// MARK: - Forecast Horizontal Card
struct ForecastHorizontalCardView: View {
    let icon: String
    let title: String
    let value1: String
    let value2: String
    
    var body: some View {
        HStack {
            // Left Side: Icon & Title
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer(minLength: 1)
            
            // Right Side: Two Values with Icons
            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemName: "arrow.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 20)
                        .foregroundColor(.green) // Down arrow in green
                    
                    
                    
                    HStack(spacing: 1) {
                        Text(formatValue(value1))
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 30, alignment: .leading)
                        
                        // Adding unit as superscript
                        if let unit = getUnit(from: value2) {
                            Text(unit)
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .offset(y: -5) // Position it as superscript
                        }
                    }
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "arrow.up")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 20)
                        .foregroundColor(.red) // Up arrow in red
                    
                    HStack(spacing: 1) {
                        Text(formatValue(value2))
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 30, alignment: .leading)
                        
                        // Adding unit as superscript
                        if let unit = getUnit(from: value2) {
                            Text(unit)
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .offset(y: -5) // Position it as superscript
                        }
                    }
                        
                    
                    
                }
            }
        }
        .frame(height: 50)
        .padding(.horizontal, 12)
        .background(Color(hex: "#0B1D29").opacity(0.25)) // Glass-like effect
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white.opacity(0.2), lineWidth: 1.56) // Softer glassmorphic border
        )
    }
    
    /// Extracts the numeric value, converts it to a whole number using `ceil`, and returns it as a string.
    private func formatValue(_ value: String) -> String {
        let components = value.split(separator: " ") // Split "number unit"
        if let number = Double(components.first ?? "") {
            return "\(Int(ceil(number)))" // Convert to whole number
        }
        return value // Fallback in case of error
    }
    
    /// Extracts the unit part of the string (e.g., "°C", "km/h").
    private func getUnit(from value: String) -> String? {
        let components = value.split(separator: " ") // Split "number unit"
        if components.count > 1 {
            return String(components.last ?? "")
        }
        return nil
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 10) {
        ForecastHorizontalCardView(
            icon: "wind",
            title: "Wind Speed",
            value1: "13.40 km/h",
            value2: "24.80 km/h"
        )
        
        ForecastHorizontalCardView(
            icon: "thermometer",
            title: "Temperature",
            value1: "108.90 °C",
            value2: "30.50 °C"
        )
    }
    .padding()
}
