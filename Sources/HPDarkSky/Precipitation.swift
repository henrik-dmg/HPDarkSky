//
//  Precipitation.swift
//  
//
//  Created by Henrik Panhans on 07.08.19.
//

import Foundation

public struct Precipitation: Codable {
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
}
