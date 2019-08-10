//
//  Precipitation.swift
//  
//
//  Created by Henrik Panhans on 07.08.19.
//

import Foundation

public struct Precipitation: Codable {
    public let intensity: Double
    public let error: Double?
    public let probability: Double
    public let type: String?
    public let maxIntensity: Double?
    public let maxIntensityTime: Date?
    public let accumulation: Double?

    enum CodingKeys: String, CodingKey {
        case intensity = "precipIntensity"
        case error = "precipIntensityError"
        case probability = "precipProbability"
        case type = "precipType"
        case maxIntensity = "precipIntensityMax"
        case maxIntensityTime = "precipIntensityMaxTime"
        case accumulation = "precipAccumulation"
    }

    public static func decode(from decoder: Decoder) throws -> Precipitation {
        let precipContainer = try decoder.container(keyedBy: CodingKeys.self)
        return Precipitation(
            intensity: try precipContainer.decode(Double.self, forKey: .intensity),
            error: try precipContainer.decodeIfPresent(Double.self, forKey: .error),
            probability: try precipContainer.decode(Double.self, forKey: .probability),
            type: try precipContainer.decodeIfPresent(String.self, forKey: .type),
            maxIntensity: try precipContainer.decodeIfPresent(Double.self, forKey: .maxIntensity),
            maxIntensityTime: try precipContainer.decodeIfPresent(Date.self, forKey: .maxIntensityTime),
            accumulation: try precipContainer.decodeIfPresent(Double.self, forKey: .accumulation))
    }
}
