//
//  File.swift
//  
//
//  Created by Henrik Panhans on 19.08.19.
//

import Foundation

///Generic type that can hold any type of data point, e.g. hourly or daily
public struct Forecast<T: Equatable & Codable>: Codable, Equatable {
    ///A human-readable text summary of this data point.
    ///(This property has millions of possible values, so don’t use it for automated purposes: use the icon property, instead!)
    public let summary: String?
    ///A weather icon representing the associated weather conditions
    public let icon: WeatherIcon?
    ///An array containing all returned data points
    public let data: [T]
}
