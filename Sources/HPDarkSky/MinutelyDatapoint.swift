//
//  MinutelyForecast.swift
//  
//
//  Created by Henrik Panhans on 08.08.19.
//

import Foundation

///Type holding information about minutely precipiation
public struct MinutelyDatapoint: Codable, Equatable {
    ///The UNIX time at which this data point begins. minutely data point are always aligned to the top of the minute,
    ///hourly data point objects to the top of the hour,
    ///and daily data point objects to midnight of the day, all according to the local time zone.
    public let time: Date
    ///The forecasted/observed precipiation
    public var precipitation: Precipitation {
        return Precipitation(
            intensity: precipIntensity,
            error: precipIntensityError,
            probability: precipProbability,
            type: precipType,
            maxIntensity: precipIntensityMax,
            maxIntensityTime: precipIntensityMaxTime,
            accumulation: precipAccumulation)
    }

    //Internal types to conform to COdable
    let precipIntensity: Double
    let precipIntensityError: Double?
    let precipProbability: Double
    let precipType: PrecipitationType?
    let precipIntensityMax: Double?
    let precipIntensityMaxTime: Date?
    let precipAccumulation: Double?
}
