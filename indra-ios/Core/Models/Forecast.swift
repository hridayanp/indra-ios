//
//  Forecast.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

import Foundation

struct Forecast: Identifiable, Decodable {
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
