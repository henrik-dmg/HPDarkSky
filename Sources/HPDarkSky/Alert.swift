//
//  Alert.swift
//  
//
//  Created by Henrik Panhans on 09.08.19.
//

import Foundation

public struct Alert: Codable {
    public let title: String
    public let timeStamp: Date
    public let expires: Date
    public let description: String
    public let url: String

    enum CodingKeys: String, CodingKey {
        case title
        case timeStamp = "time"
        case expires
        case description
        case url = "uri"
    }
}
