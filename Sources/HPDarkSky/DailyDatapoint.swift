//
//  DailyForecast.swift
//  
//
//  Created by Henrik Panhans on 09.08.19.
//

import Foundation

/// A datapoint that holds information about the average daily weather conditions
public struct DailyDatapoint: Codable, Equatable {
    /// The daytime high apparent temperature.
    public let apparentTemperatureHigh: Double
    /// The time representing when the daytime high apparent temperature occurs.
    public let apparentTemperatureHighTime: Date
    /// The overnight low apparent temperature.
    public let apparentTemperatureLow: Double
    /// The time representing when the overnight low apparent temperature occurs.
    public let apparentTemperatureLowTime: Date
    /// The maximum apparent temperature during a given date.
    public let apparentTemperatureMax: Double
    /// The time representing when the maximum apparent temperature during a given date occurs.
    public let apparentTemperatureMaxTime: Date
    /// The minimum apparent temperature during a given date.
    public let apparentTemperatureMin: Double
    /// The time representing when the minimum apparent temperature during a given date occurs.
    public let apparentTemperatureMinTime: Date
    /// The fractional part of the lunation number during the given day: a value of 0 corresponds to a new moon,
    /// 0.25 to a first quarter moon, 0.5 to a full moon, and 0.75 to a last quarter moon.
    /// (The ranges in between these represent waxing crescent, waxing gibbous, waning gibbous, and waning crescent moons, respectively.)
    public let moonPhase: Double
    /// The time of when the sun will rise during a given day.
    public let sunriseTime: Date
    /// The time of when the sun will set during a given day.
    public let sunsetTime: Date
    /// The daytime high temperature.
    public let temperatureHigh: Double
    /// The time representing when the daytime high temperature occurs.
    public let temperatureHighTime: Date
    /// The overnight low temperature.
    public let temperatureLow: Double
    /// The time representing when the overnight low temperature occurs.
    public let temperatureLowTime: Date
    /// The maximum temperature during a given date.
    public let temperatureMax: Double
    /// The time representing when the maximum temperature during a given date occurs.
    public let temperatureMaxTime: Date
    /// The minimum temperature during a given date.
    public let temperatureMin: Double
    /// The time representing when the minimum temperature during a given date occurs.
    public let temperatureMinTime: Date
    /// The time of when the maximum uvIndex occurs during a given day.
    public let uvIndexTime: Double
    ///The percentage of sky occluded by clouds, between 0 and 1, inclusive.
    public let cloudCover: Double
    ///The dew point in degrees
    public let dewPoint: Double
    ///The relative humidity, between 0 and 1, inclusive.
    public let humidity: Double
    ///A weather icon representing the associated weather conditions
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
