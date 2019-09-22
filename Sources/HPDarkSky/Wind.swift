//
//  Wind.swift
//  
//
//  Created by Henrik Panhans on 07.08.19.
//

import Foundation

///Type holding information about the wind, such as speed, bearing and gust
public struct Wind: Codable, Equatable {
    ///The speed of the wind
    public let speed: Double
    ///The wind gust speed
    public let gust: Double
    ///The direction that the wind is coming from in degrees, with true north at 0° and progressing clockwise.
    ///(If windSpeed is zero, then this value will be nil)
    public let bearing: Int?
    ///The time at which the maximum wind gust speed occurs during the day.
    public let gustTime: Date?
}
