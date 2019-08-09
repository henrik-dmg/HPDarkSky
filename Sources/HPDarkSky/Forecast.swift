//
//  File.swift
//  
//
//  Created by Henrik Panhans on 06.08.19.
//

import Foundation
import CoreLocation

public struct Forecast: Codable, CustomStringConvertible {

    private let flags: Flags
    public let location: CLLocationCoordinate2D
    public let timezone: TimeZone
    public let currently: WeatherDatapoint?
    public let minutely: MinutelyForecast?
    public let hourly: HourlyForecast?
    public let daily: DailyForecast?
    public let alerts: [Alert]?
    public var units: Units {
        return flags.units
    }

    enum CodingKeys: String, CodingKey {
        case location
        case timezone
        case currently
        case minutely
        case hourly
        case daily
        case alerts
        case flags
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.location = try CLLocationCoordinate2D.decode(from: decoder)
        self.timezone = try TimeZone.decode(from: decoder)
        self.currently = try container.decodeIfPresent(WeatherDatapoint.self, forKey: .currently)
        self.minutely = try container.decodeIfPresent(MinutelyForecast.self, forKey: .minutely)
        self.hourly = try container.decodeIfPresent(HourlyForecast.self, forKey: .hourly)
        self.daily = try container.decodeIfPresent(DailyForecast.self, forKey: .daily)
        self.alerts = try container.decodeIfPresent([Alert].self, forKey: .alerts)
        self.flags = try container.decode(Flags.self, forKey: .flags)
    }
    
    public var description: String {
        let className = type(of: self)
        return "\(className)(location: \(location), timeZone: \(timezone.identifier))"
    }
}
