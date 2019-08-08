//
//  File.swift
//  
//
//  Created by Henrik Panhans on 06.08.19.
//

import Foundation
import CoreLocation

public struct Forecast: Codable {
    let location: CLLocationCoordinate2D
    let timezone: String
    let currently: CurrentWeather?
    let minutely: MinutelyWeather?

    enum CodingKeys: String, CodingKey {
        case location
        case timezone
        case currently
        case minutely
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.location = try CLLocationCoordinate2D.decode(from: decoder)
        self.timezone = try container.decode(String.self, forKey: .timezone)
        self.currently = try container.decodeIfPresent(CurrentWeather.self, forKey: .currently)
        self.minutely = try container.decodeIfPresent(MinutelyWeather.self, forKey: .minutely)
    }
}
