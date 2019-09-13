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
}

public enum PrecipitationType: String, Codable, Equatable {
    ///Self-explanatory
    case rain
    ///Self-explanatory
    case snow
    ///Refers to each of freezing rain, ice pellets, and “wintery mix”
    case sleet
}
