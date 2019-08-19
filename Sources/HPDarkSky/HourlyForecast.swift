//
//  File.swift
//  
//
//  Created by Henrik Panhans on 10.08.19.
//

import Foundation

///An hourly forecast which holds hourly datapoints
public class HourlyForecast: BasicForecast {
    public let datapoints: [HourlyDatapoint]

    enum HourlyCodingKeys: String, CodingKey {
        case datapoints = "data"
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HourlyCodingKeys.self)
        self.datapoints = try container.decode([HourlyDatapoint].self, forKey: .datapoints)

        try super.init(from: decoder)
    }
}

public class HourlyDatapoint: BasicDatapoint {
    /// The apparent (or “feels like”) temperature in degrees Fahrenheit.
    public let apparentTemperature: Double
    /// The air temperature in degrees Fahrenheit.
    public let temperature: Double

    enum HourlyDatapointKeys: String, CodingKey {
        case apparentTemperature
        case temperature
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HourlyDatapointKeys.self)
        self.apparentTemperature = try container.decode(Double.self, forKey: .apparentTemperature)
        self.temperature = try container.decode(Double.self, forKey: .temperature)

        try super.init(from: decoder)
    }
}
