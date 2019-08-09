//
//  MinutelyForecast.swift
//  
//
//  Created by Henrik Panhans on 08.08.19.
//

import Foundation

public struct MinutelyForecast: Codable {
    public let summary: String
    public let icon: WeatherIcon
    public let dataPoints: [MinutelyDatapoint]

    enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case dataPoints = "data"
    }
}

public struct MinutelyDatapoint: Codable {
    public let timeStamp: Date
    public let precipitation: Precipitation

    enum CodingKeys: String, CodingKey {
        case timeStamp = "time"
        case precipitation
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.timeStamp = try container.decode(Date.self, forKey: .timeStamp)
        self.precipitation = try Precipitation.decode(from: decoder)
    }
}
