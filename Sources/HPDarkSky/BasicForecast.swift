//
//  File.swift
//  
//
//  Created by Henrik Panhans on 10.08.19.
//

import Foundation

///A base class for forecast objects
public class BasicForecast: Codable, Equatable {
    public static func == (lhs: BasicForecast, rhs: BasicForecast) -> Bool {
        return lhs.summary == rhs.summary && lhs.icon == rhs.icon
    }

    ///A human-readable text summary of this data point.
    ///(This property has millions of possible values, so don’t use it for automated purposes: use the icon property, instead!)
    public let summary: String
    public let icon: WeatherIcon
}
