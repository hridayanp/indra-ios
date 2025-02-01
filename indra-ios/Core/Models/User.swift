//
//  User.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 31/01/25.
//

import Foundation

struct User : Codable {
    let userId: Int
    let email: String
    let username: String
    let role: Int
    let roleName: String
    let accessToken: String
    let refreshToken: String
}
