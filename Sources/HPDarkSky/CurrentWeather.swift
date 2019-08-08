//
//  File.swift
//  
//
//  Created by Henrik Panhans on 06.08.19.
//

import Foundation

public struct CurrentWeather: Codable {
    let timeStamp: Date
    let summary: String
    let iconName: String
    let nearestStormDistance: Double
    let precipitation: Precipitation
    let temperature: Double
    let apparentTemperature: Double
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let wind: Wind
    let cloudCover: Double
    let uvIndex: Int
    let visibility: Double
    let ozone: Double
    
    enum CodingKeys: String, CodingKey {
        case timeStamp = "time"
        case summary
        case iconName = "icon"
        case nearestStormDistance
        case precipitation
        case temperature
        case apparentTemperature
        case dewPoint
        case humidity
        case pressure
        case wind
        case cloudCover
        case uvIndex
        case visibility
        case ozone
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.timeStamp = try container.decode(Date.self, forKey: .timeStamp)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.iconName = try container.decode(String.self, forKey: .iconName)
        self.nearestStormDistance = try container.decode(Double.self, forKey: .nearestStormDistance)
        self.temperature = try container.decode(Double.self, forKey: .temperature)
        self.apparentTemperature = try container.decode(Double.self, forKey: .apparentTemperature)
        self.dewPoint = try container.decode(Double.self, forKey: .dewPoint)
        self.humidity = try container.decode(Double.self, forKey: .humidity)
        self.pressure = try container.decode(Double.self, forKey: .pressure)
        self.cloudCover = try container.decode(Double.self, forKey: .cloudCover)
        self.uvIndex = try container.decode(Int.self, forKey: .uvIndex)
        self.visibility = try container.decode(Double.self, forKey: .visibility)
        self.ozone = try container.decode(Double.self, forKey: .ozone)
        
        let precipContainer = try decoder.container(keyedBy: Precipitation.CodingKeys.self)
        self.precipitation = Precipitation(
            intensity: try precipContainer.decode(Double.self, forKey: .intensity),
            error: try precipContainer.decodeIfPresent(Double.self, forKey: .error),
            probability: try precipContainer.decode(Double.self, forKey: .probability),
            type: try precipContainer.decode(String.self, forKey: .type))
        
        let windContainer = try decoder.container(keyedBy: Wind.CodingKeys.self)
        self.wind = Wind(
            speed: try windContainer.decode(Double.self, forKey: .speed),
            gust: try windContainer.decode(Double.self, forKey: .gust),
            bearing: try windContainer.decode(Int.self, forKey: .bearing),
            gustTime: try windContainer.decodeIfPresent(Date.self, forKey: .gustTime))
    }
}
