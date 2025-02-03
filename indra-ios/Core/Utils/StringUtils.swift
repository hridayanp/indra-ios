//
//  StringUtils.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 03/02/25.
//

import Foundation

/// Extracts the numeric value, converts it to a whole number using `ceil`, and returns it as a string.
func formatValue(_ value: String) -> String {
    let components = value.split(separator: " ") // Split "number unit"
    if let number = Double(components.first ?? "") {
        return "\(Int(ceil(number)))" // Convert to whole number
    }
    return value // Fallback in case of error
}

/// Extracts the unit part of the string (e.g., "°C", "km/h").
func getUnit(from value: String) -> String? {
    let components = value.split(separator: " ") // Split "number unit"
    if components.count > 1 {
        return String(components.last ?? "")
    }
    return nil
}
