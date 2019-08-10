//
//  DailyForecast.swift
//  
//
//  Created by Henrik Panhans on 09.08.19.
//

import Foundation

public class DailyForecast: BasicForecast {
    let datapoints: [DailyDatapoint]

    enum DailyCodingKeys: String, CodingKey {
        case datapoints = "data"
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DailyCodingKeys.self)
        self.datapoints = try container.decode([DailyDatapoint].self, forKey: .datapoints)

        try super.init(from: decoder)
    }
}

public class DailyDatapoint: BasicDatapoint {
    /// The daytime high apparent temperature.
    public let apparentTemperatureHigh: Double
    /// The UNIX time representing when the daytime high apparent temperature occurs.
    public let apparentTemperatureHighTime: Date
    /// The overnight low apparent temperature.
    public let apparentTemperatureLow: Double
    /// The UNIX time representing when the overnight low apparent temperature occurs.
    public let apparentTemperatureLowTime: Date
    /// The maximum apparent temperature during a given date.
    public let apparentTemperatureMax: Double
    /// The UNIX time representing when the maximum apparent temperature during a given date occurs.
    public let apparentTemperatureMaxTime: Date
    /// The minimum apparent temperature during a given date.
    public let apparentTemperatureMin: Double
    /// The UNIX time representing when the minimum apparent temperature during a given date occurs.
    public let apparentTemperatureMinTime: Date
    /// The fractional part of the lunation number during the given day: a value of 0 corresponds to a new moon,
    /// 0.25 to a first quarter moon, 0.5 to a full moon, and 0.75 to a last quarter moon.
    /// (The ranges in between these represent waxing crescent, waxing gibbous, waning gibbous, and waning crescent moons, respectively.)
    public let moonPhase: Double
    /// The UNIX time of when the sun will rise during a given day.
    public let sunriseTime: Date
    /// The UNIX time of when the sun will set during a given day.
    public let sunsetTime: Date
    /// The daytime high temperature.
    public let temperatureHigh: Double
    /// The UNIX time representing when the daytime high temperature occurs.
    public let temperatureHighTime: Date
    /// The overnight low temperature.
    public let temperatureLow: Double
    /// The UNIX time representing when the overnight low temperature occurs.
    public let temperatureLowTime: Date
    /// The maximum temperature during a given date.
    public let temperatureMax: Double
    /// The UNIX time representing when the maximum temperature during a given date occurs.
    public let temperatureMaxTime: Date
    /// The minimum temperature during a given date.
    public let temperatureMin: Double
    /// The UNIX time representing when the minimum temperature during a given date occurs.
    public let temperatureMinTime: Date
    /// The UNIX time of when the maximum uvIndex occurs during a given day.
    public let uvIndexTime: Double

    enum DailyDataPointKeys: String, CodingKey {
        case apparentTemperatureHigh
        case apparentTemperatureHighTime
        case apparentTemperatureLow
        case apparentTemperatureLowTime
        case apparentTemperatureMax
        case apparentTemperatureMaxTime
        case apparentTemperatureMin
        case apparentTemperatureMinTime
        case moonPhase
        case sunriseTime
        case sunsetTime
        case temperatureHigh
        case temperatureHighTime
        case temperatureLow
        case temperatureLowTime
        case temperatureMax
        case temperatureMaxTime
        case temperatureMin
        case temperatureMinTime
        case uvIndexTime
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DailyDataPointKeys.self)

        self.apparentTemperatureHigh = try container.decode(Double.self, forKey: .apparentTemperatureHigh)
        self.apparentTemperatureHighTime = try container.decode(Date.self, forKey: .apparentTemperatureHighTime)
        self.apparentTemperatureLow = try container.decode(Double.self, forKey: .apparentTemperatureLow)
        self.apparentTemperatureLowTime = try container.decode(Date.self, forKey: .apparentTemperatureLowTime)
        self.apparentTemperatureMax = try container.decode(Double.self, forKey: .apparentTemperatureMax)
        self.apparentTemperatureMaxTime = try container.decode(Date.self, forKey: .apparentTemperatureMaxTime)
        self.apparentTemperatureMin = try container.decode(Double.self, forKey: .apparentTemperatureMin)
        self.apparentTemperatureMinTime = try container.decode(Date.self, forKey: .apparentTemperatureMinTime)
        self.moonPhase = try container.decode(Double.self, forKey: .moonPhase)
        self.sunriseTime = try container.decode(Date.self, forKey: .sunriseTime)
        self.sunsetTime = try container.decode(Date.self, forKey: .sunsetTime)
        self.temperatureHigh = try container.decode(Double.self, forKey: .temperatureHigh)
        self.temperatureHighTime = try container.decode(Date.self, forKey: .temperatureHighTime)
        self.temperatureLow = try container.decode(Double.self, forKey: .temperatureLow)
        self.temperatureLowTime = try container.decode(Date.self, forKey: .temperatureLowTime)
        self.temperatureMax = try container.decode(Double.self, forKey: .temperatureMax)
        self.temperatureMaxTime = try container.decode(Date.self, forKey: .temperatureMaxTime)
        self.temperatureMin = try container.decode(Double.self, forKey: .temperatureMin)
        self.temperatureMinTime = try container.decode(Date.self, forKey: .temperatureMinTime)
        self.uvIndexTime = try container.decode(Double.self, forKey: .uvIndexTime)

        try super.init(from: decoder)
    }
}
