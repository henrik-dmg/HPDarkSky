//
//  File.swift
//  
//
//  Created by Henrik Panhans on 10.08.19.
//

import Foundation

///A datapoint object that contains the most basic information covered in almost every data block
public class BasicDatapoint: Codable, Equatable {
    public static func == (lhs: BasicDatapoint, rhs: BasicDatapoint) -> Bool {
        return
            lhs.precipitation == rhs.precipitation &&
            lhs.cloudCover == rhs.cloudCover &&
            lhs.dewPoint == rhs.dewPoint &&
            lhs.humidity == rhs.humidity &&
            lhs.icon == rhs.icon &&
            lhs.ozone == rhs.ozone &&
            lhs.pressure == rhs.pressure &&
            lhs.summary == rhs.summary &&
            lhs.time == rhs.time &&
            lhs.uvIndex == rhs.uvIndex &&
            lhs.visibility == rhs.visibility &&
            lhs.wind == rhs.wind
    }
    
    ///The percentage of sky occluded by clouds, between 0 and 1, inclusive.
    public let cloudCover: Double
    ///The dew point in degrees
    public let dewPoint: Double
    ///The relative humidity, between 0 and 1, inclusive.
    public let humidity: Double
    public let icon: WeatherIcon
    ///The columnar density of total atmospheric ozone at the given time in Dobson units.
    public let ozone: Double
    ///The forecasted/observed precipiation
    public let precipitation: Precipitation
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
    public let wind: Wind

    enum CodingKeys: String, CodingKey {
        case cloudCover
        case dewPoint
        case humidity
        case icon
        case ozone
        case precipitation
        case pressure
        case summary
        case time
        case uvIndex
        case visibility
        case wind
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.time = try container.decode(Date.self, forKey: .time)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.icon = try container.decode(WeatherIcon.self, forKey: .icon)
        self.dewPoint = try container.decode(Double.self, forKey: .dewPoint)
        self.humidity = try container.decode(Double.self, forKey: .humidity)
        self.pressure = try container.decode(Double.self, forKey: .pressure)
        self.cloudCover = try container.decode(Double.self, forKey: .cloudCover)
        self.uvIndex = try container.decode(Int.self, forKey: .uvIndex)
        self.visibility = try container.decode(Double.self, forKey: .visibility)
        self.ozone = try container.decode(Double.self, forKey: .ozone)
        self.wind = try Wind.decode(from: decoder)
        self.precipitation = try Precipitation.decode(from: decoder)
    }
}

public class CurrentDatapoint: BasicDatapoint {
    /// The current temperature
    public let temperature: Double

    enum CurrentDatapointKeys: String, CodingKey {
        case temperature
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CurrentDatapointKeys.self)

        self.temperature = try container.decode(Double.self, forKey: .temperature)
        try super.init(from: decoder)
    }
}

