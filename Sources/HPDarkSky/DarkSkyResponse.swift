//
//  File.swift
//  
//
//  Created by Henrik Panhans on 06.08.19.
//

import Foundation
import CoreLocation

public struct DarkSkyResponse: Codable, CustomStringConvertible, Equatable {

    ///A flags object containing miscellaneous metadata about the request.
    public let flags: Flags
    ///The requested location
    public var location: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    ///The timezone for the requested location.
    public var timezone: TimeZone {
        return TimeZone(identifier: timezoneIdentifier)!
    }
    ///A data point containing the current weather conditions at the requested location.
    public let currently: CurrentDatapoint?
    ///A data block containing the weather conditions minute-by-minute for the next hour.
    public let minutely: MinutelyForecast?
    ///A data block containing the weather conditions hour-by-hour for the next two days.
    public let hourly: HourlyForecast?
    ///A data block containing the weather conditions day-by-day for the next week.
    public let daily: DailyForecast?
    ///An alerts array, which, if present, contains any severe weather alerts pertinent to the requested location.
    public let alerts: [Alert]?

    //Internal vars to conform to Codable
    let longitude: Double
    let latitude: Double
    let timezoneIdentifier: String

    enum CodingKeys: String, CodingKey {
        case currently
        case minutely
        case hourly
        case daily
        case alerts
        case flags
        case longitude
        case latitude
        case timezoneIdentifier = "timezone"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.timezoneIdentifier = try container.decode(String.self, forKey: .timezoneIdentifier)
        self.currently = try container.decodeIfPresent(CurrentDatapoint.self, forKey: .currently)
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
