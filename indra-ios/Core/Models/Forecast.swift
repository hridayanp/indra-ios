//
//  Forecast.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

import Foundation

struct ForecastPrev: Identifiable, Decodable {
    let dob: String
    let address: String
    let pin: Int
    let district: String
    let state: String
    let email: String
    let id: Int
    let phone: String
    let name: String
    let locationId: Int
    let locationName: String
    let gender: String
}


struct Forecast: Identifiable {
    let id = UUID() // Unique identifier
    let date: String
    let time: String
    let info: [ForecastInfo]
}

struct ForecastInfo {
    let type: String
    let label: String
    let value: String
    let unit: String
}
