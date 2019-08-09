//
//  HourlyForecast.swift
//  
//
//  Created by Henrik Panhans on 08.08.19.
//

import Foundation

public struct HourlyForecast: Codable {
    public let summary: String
    public let icon: String
    public let dataPoints: [WeatherDatapoint]

    enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case dataPoints = "data"
    }
}
