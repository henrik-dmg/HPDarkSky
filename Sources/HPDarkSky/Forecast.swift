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
    let timezone: TimeZone
    let currently: WeatherDatapoint?
    let minutely: MinutelyForecast?
    let hourly: HourlyForecast?
    let daily: DailyForecast?
    let alerts: [Alert]?

    enum CodingKeys: String, CodingKey {
        case location
        case timezone
        case currently
        case minutely
        case hourly
        case daily
        case alerts
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
    }
}
