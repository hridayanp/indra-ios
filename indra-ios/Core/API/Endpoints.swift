//
//  Endpoints.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

import Foundation

struct Endpoints {
    static let baseURL = "https://api-climachain.dev2prod.co"
    
    struct Auth {
        static let login = "\(baseURL)/api/token"
        static let signup = "\(baseURL)/signup"
    }
    
    struct Forecast {
        static let getForecasts = "\(baseURL)/users/api/farmer"
    }
}

