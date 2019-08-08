//
//  Wind.swift
//  
//
//  Created by Henrik Panhans on 07.08.19.
//

import Foundation

public struct Wind: Codable {
    let speed: Double
    let gust: Double
    let bearing: Int
    let gustTime: Date?
    
    enum CodingKeys: String, CodingKey {
        case speed = "windSpeed"
        case gust = "windGust"
        case bearing = "windBearing"
        case gustTime = "windGustTime"
    }
}
