//
//  Wind.swift
//  
//
//  Created by Henrik Panhans on 07.08.19.
//

import Foundation

public struct Wind: Codable {
    
    static let none = Wind(speed: 0, gust: 0, bearing: 0, gustTime: nil)

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
    
    public static func decode(from decoder: Decoder) throws -> Wind {
        let windContainer = try decoder.container(keyedBy: CodingKeys.self)
        return Wind(
            speed: try windContainer.decode(Double.self, forKey: .speed),
            gust: try windContainer.decode(Double.self, forKey: .gust),
            bearing: try windContainer.decode(Int.self, forKey: .bearing),
            gustTime: try windContainer.decodeIfPresent(Date.self, forKey: .gustTime))
    }
}
