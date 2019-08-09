//
//  Alert.swift
//  
//
//  Created by Henrik Panhans on 09.08.19.
//

import Foundation

public struct Alert: Codable {
    let title: String
    let timeStamp: Date
    let expires: Date
    let description: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case timeStamp = "time"
        case expires
        case description
        case url = "uri"
    }
}
