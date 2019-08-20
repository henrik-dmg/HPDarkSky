//
//  File.swift
//  
//
//  Created by Henrik Panhans on 10.08.19.
//

import Foundation

///A datapoint that holds basic information and also the current temperature
public struct CurrentDatapoint: Codable, Equatable {
    public static func == (lhs: CurrentDatapoint, rhs: CurrentDatapoint) -> Bool {
        return lhs.windSpeed == rhs.windSpeed &&
            lhs.windGust == rhs.windGust &&
            lhs.windBearing == rhs.windBearing &&
            lhs.windGustTime == rhs.windGustTime &&
            lhs.precipIntensity == rhs.precipIntensity &&
            lhs.precipIntensityError == rhs.precipIntensityError &&
            lhs.precipProbability == rhs.precipProbability &&
            lhs.precipType == rhs.precipType &&
            lhs.precipIntensityMax == rhs.precipIntensityMax &&
            lhs.precipIntensityMaxTime == rhs.precipIntensityMaxTime &&
            lhs.precipAccumulation == rhs.precipAccumulation &&
            lhs.temperature == rhs.temperature &&
            lhs.cloudCover == rhs.cloudCover &&
            lhs.dewPoint == rhs.dewPoint &&
            lhs.humidity == rhs.humidity &&
            lhs.icon == rhs.icon &&
            lhs.ozone == rhs.ozone &&
            lhs.pressure == rhs.pressure &&
            lhs.summary == rhs.summary &&
            lhs.time == rhs.time &&
            lhs.uvIndex == rhs.uvIndex &&
            lhs.visibility == rhs.visibility
    }
    /// The current temperature
    public let temperature: Double
    ///The percentage of sky occluded by clouds, between 0 and 1, inclusive.
    public let cloudCover: Double
    ///The dew point in degrees
    public let dewPoint: Double
    ///The relative humidity, between 0 and 1, inclusive.
    public let humidity: Double
    public let icon: WeatherIcon
    ///The columnar density of total atmospheric ozone at the given time in Dobson units.
    public let ozone: Double
    ///The sea-level air pressure in millibars.
    public let pressure: Double
    ///A human-readable text summary of this data point.
    ///(This property has millions of possible values, so don’t use it for automated purposes: use the icon property, instead!)
    public let summary: String
    ///The UNIX time at which this data point begins. minutely data point are always aligned to the top of the minute,
    ///hourly data point objects to the top of the hour,
    ///and daily data point objects to midnight of the day, all according to the local time zone.
    public let time: Date
    ///The UV index.
    public let uvIndex: Int
    ///The average visibility in miles, capped at 10 miles.
    public let visibility: Double
    ///Holds information about the forecasted/observed wind
    public var wind: Wind {
        return Wind(speed: windSpeed, gust: windGust, bearing: windBearing, gustTime: windGustTime)
    }
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

    //Internal variables to conform to Codable
    let windSpeed: Double
    let windGust: Double
    let windBearing: Int?
    let windGustTime: Date?
    let precipIntensity: Double
    let precipIntensityError: Double?
    let precipProbability: Double
    let precipType: PrecipitationType?
    let precipIntensityMax: Double?
    let precipIntensityMaxTime: Date?
    let precipAccumulation: Double?
}
