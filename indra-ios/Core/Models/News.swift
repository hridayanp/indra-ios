//
//  News.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 02/02/25.
//

import Foundation

struct NewsItem: Identifiable, Decodable {
    var id: String {
        return url // or any unique identifier
    }
    
    let author: String
    let content: String
    let date: String
    let imageUrl: String
    let readMoreUrl: String
    let time: String
    let title: String
    let url: String
    
}

struct NewsResponse: Decodable {
    let category: String
    let data: [NewsItem]
    let success: Bool
}
