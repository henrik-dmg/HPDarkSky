//
//  Precipitation.swift
//  
//
//  Created by Henrik Panhans on 07.08.19.
//

import Foundation

///Type holding information about precipitation, such as snow/rain/etc.
public struct Precipitation: Codable, Equatable {
    ///The intensity (in inches/centimeters of liquid water per hour) of precipitation occurring at the given time.
    ///This value is conditional on probability (that is, assuming any precipitation occurs at all).
    public let intensity: Double
    ///The standard deviation of the distribution of precipIntensity.
    ///(Only returned when the full distribution, and not merely the expected mean, can be estimated with accuracy.)
    public let error: Double?
    ///The probability of precipitation occurring, between 0 and 1, inclusive.
    public let probability: Double
    ///The type of precipitation occurring at the given time.
    public let type: PrecipitationType?
    ///The maximum value of intensity during a given day.
    public let maxIntensity: Double?
    ///The time of day when maxIntensity occurs
    public let maxIntensityTime: Date?
    ///The amount of snowfall accumulation expected to occur, in inches/centimeters.
    ///(If no snowfall is expected, this property will not be defined.)
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
            type: try precipContainer.decodeIfPresent(PrecipitationType.self, forKey: .type),
            maxIntensity: try precipContainer.decodeIfPresent(Double.self, forKey: .maxIntensity),
            maxIntensityTime: try precipContainer.decodeIfPresent(Date.self, forKey: .maxIntensityTime),
            accumulation: try precipContainer.decodeIfPresent(Double.self, forKey: .accumulation))
    }
}

public enum PrecipitationType: String, Codable, Equatable {
    ///Self-explanatory
    case rain
    ///Self-explanatory
    case snow
    ///Refers to each of freezing rain, ice pellets, and “wintery mix”
    case sleet
}
