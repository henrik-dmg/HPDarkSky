//
//  DailyForecast.swift
//  
//
//  Created by Henrik Panhans on 09.08.19.
//

import Foundation

public struct DailyForecast: Codable {
    public let summary: String
    public let icon: WeatherIcon
    public let dataPoints: [DailyDatapoint]

    enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case dataPoints = "data"
    }
}

public struct DailyDatapoint: Codable {
    public let timeStamp: Date
    public let summary: String
    public let icon: WeatherIcon
    public let sunrise: Date
    public let sunset: Date
    public let moonPhase: Double
    public let precipitation: Precipitation
    public let maxTemperature: Double
    public let maxTemperatureTime: Date
    public let minTemperature: Double
    public let minTemperatureTime: Date
    public let apparentMaxTemperature: Double
    public let apparentMaxTemperatureTime: Date
    public let apparentMinTemperature: Double
    public let apparentMinTemperatureTime: Date
    public let dewPoint: Double
    public let humidity: Double
    public let pressure: Double
    public let wind: Wind
    public let cloudCover: Double
    public let uvIndex: Double
    public let uvIndexTime: Date
    public let visibility: Double
    public let ozone: Double

    enum CodingKeys: String, CodingKey {
        case timeStamp = "time"
        case summary
        case icon
        case sunrise = "sunriseTime"
        case sunset = "sunsetTime"
        case moonPhase
        case precipitation
        case maxTemperature = "temperatureHigh"
        case maxTemperatureTime = "temperatureHighTime"
        case minTemperature = "temperatureLow"
        case minTemperatureTime = "temperatureLowTime"
        case apparentMaxTemperature = "apparentTemperatureHigh"
        case apparentMaxTemperatureTime = "apparentTemperatureHighTime"
        case apparentMinTemperature = "apparentTemperatureLow"
        case apparentMinTemperatureTime = "apparentTemperatureLowTime"
        case dewPoint
        case humidity
        case pressure
        case wind
        case cloudCover
        case uvIndex
        case uvIndexTime
        case visibility
        case ozone
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.timeStamp = try container.decode(Date.self, forKey: .timeStamp)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.icon = try container.decode(WeatherIcon.self, forKey: .icon)
        self.sunrise = try container.decode(Date.self, forKey: .sunrise)
        self.sunset = try container.decode(Date.self, forKey: .sunset)
        self.moonPhase = try container.decode(Double.self, forKey: .moonPhase)
        self.maxTemperature = try container.decode(Double.self, forKey: .maxTemperature)
        self.maxTemperatureTime = try container.decode(Date.self, forKey: .maxTemperatureTime)
        self.minTemperature = try container.decode(Double.self, forKey: .minTemperature)
        self.minTemperatureTime = try container.decode(Date.self, forKey: .minTemperatureTime)
        self.apparentMaxTemperature = try container.decode(Double.self, forKey: .apparentMaxTemperature)
        self.apparentMaxTemperatureTime = try container.decode(Date.self, forKey: .apparentMaxTemperatureTime)
        self.apparentMinTemperature = try container.decode(Double.self, forKey: .apparentMinTemperature)
        self.apparentMinTemperatureTime = try container.decode(Date.self, forKey: .apparentMinTemperatureTime)
        self.dewPoint = try container.decode(Double.self, forKey: .dewPoint)
        self.humidity = try container.decode(Double.self, forKey: .humidity)
        self.pressure = try container.decode(Double.self, forKey: .pressure)
        self.cloudCover = try container.decode(Double.self, forKey: .cloudCover)
        self.uvIndex = try container.decode(Double.self, forKey: .uvIndex)
        self.uvIndexTime = try container.decode(Date.self, forKey: .uvIndexTime)
        self.visibility = try container.decode(Double.self, forKey: .visibility)
        self.ozone = try container.decode(Double.self, forKey: .ozone)
        self.wind = try Wind.decode(from: decoder)
        self.precipitation = try Precipitation.decode(from: decoder)
    }
}
