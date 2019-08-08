//
//  Precipitation.swift
//  
//
//  Created by Henrik Panhans on 07.08.19.
//

import Foundation

public struct Precipitation: Codable {

    static let none = Precipitation(intensity: 0, error: 0, probability: 0, type: "none")

    let intensity: Double
    let error: Double?
    let probability: Double
    let type: String

    enum CodingKeys: String, CodingKey {
        case intensity = "precipIntensity"
        case error = "precipIntensityError"
        case probability = "precipProbability"
        case type = "precipType"
    }

    public static func decode(from decoder: Decoder) throws -> Precipitation {
        let precipContainer = try decoder.container(keyedBy: CodingKeys.self)
        return Precipitation(
            intensity: try precipContainer.decode(Double.self, forKey: .intensity),
            error: try precipContainer.decodeIfPresent(Double.self, forKey: .error),
            probability: try precipContainer.decode(Double.self, forKey: .probability),
            type: try precipContainer.decode(String.self, forKey: .type))
    }
}
