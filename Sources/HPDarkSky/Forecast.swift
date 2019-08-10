//
//  File.swift
//  
//
//  Created by Henrik Panhans on 10.08.19.
//

import Foundation

public class Forecast: Codable {
    public let summary: String
    public let icon: WeatherIcon

    enum CodingKeys: String, CodingKey {
        case summary
        case icon
    }
}
