//
//  File.swift
//  
//
//  Created by Henrik Panhans on 19.08.19.
//

import Foundation

public struct Forecast<T>: Codable, Equatable where T: Codable, T: Equatable {
    ///A human-readable text summary of this data point.
    ///(This property has millions of possible values, so don’t use it for automated purposes: use the icon property, instead!)
    public let summary: String
    public let icon: WeatherIcon
    public let data: [T]
}
