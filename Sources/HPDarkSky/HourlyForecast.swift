//
//  HourlyForecast.swift
//  
//
//  Created by Henrik Panhans on 08.08.19.
//

import Foundation

public struct HourlyForecast: Codable {
    public let summary: String
    public let dataPoints: [HourlyDataPoint]
}

public struct HourlyDataPoint: Codable {
    let timeStamp: Date
    let summary: String
    // Icon
    let precipitation: Precipitation
    let temperature: Double
    let apparentTemperature: Double
    let dewPoint: Double
    let humidity: Double
    
}
