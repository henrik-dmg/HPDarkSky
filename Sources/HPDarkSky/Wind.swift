//
//  Wind.swift
//  
//
//  Created by Henrik Panhans on 07.08.19.
//

import Foundation

public struct Wind: Codable {
    public let speed: Double
    public let gust: Double
    public let bearing: Int?
    public let gustTime: Date?

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
            bearing: try windContainer.decodeIfPresent(Int.self, forKey: .bearing),
            gustTime: try windContainer.decodeIfPresent(Date.self, forKey: .gustTime))
    }
}
