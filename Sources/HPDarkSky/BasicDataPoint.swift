//
//  File.swift
//  
//
//  Created by Henrik Panhans on 10.08.19.
//

import Foundation

public class BasicDatapoint: Codable {
    let cloudCover: Double
    let dewPoint: Double
    let humidity: Double
    let icon: WeatherIcon
    let ozone: Double
    let precipitation: Precipitation
    let pressure: Double
    let summary: String
    let time: Date
    let uvIndex: Int
    let visibility: Double
    let wind: Wind

    enum CodingKeys: String, CodingKey {
        case cloudCover
        case dewPoint
        case humidity
        case icon
        case ozone
        case precipitation
        case pressure
        case summary
        case time
        case uvIndex
        case visibility
        case wind
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.time = try container.decode(Date.self, forKey: .time)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.icon = try container.decode(WeatherIcon.self, forKey: .icon)
        self.dewPoint = try container.decode(Double.self, forKey: .dewPoint)
        self.humidity = try container.decode(Double.self, forKey: .humidity)
        self.pressure = try container.decode(Double.self, forKey: .pressure)
        self.cloudCover = try container.decode(Double.self, forKey: .cloudCover)
        self.uvIndex = try container.decode(Int.self, forKey: .uvIndex)
        self.visibility = try container.decode(Double.self, forKey: .visibility)
        self.ozone = try container.decode(Double.self, forKey: .ozone)
        self.wind = try Wind.decode(from: decoder)
        self.precipitation = try Precipitation.decode(from: decoder)
    }
}
