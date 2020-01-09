import Foundation
import CoreLocation

/// Type holding any information that is returned by the API
public struct DarkSkyResponse: Codable {
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
    public let minutely: Forecast<MinutelyDatapoint>?
    ///A data block containing the weather conditions hour-by-hour for the next two days.
    public let hourly: Forecast<HourlyDatapoint>?
    ///A data block containing the weather conditions day-by-day for the next week.
    public let daily: Forecast<DailyDatapoint>?
    ///An alerts array, which, if present, contains any severe weather alerts pertinent to the requested location.
    public let alerts: [Alert]?

    //Internal vars to conform to Codable
    let longitude: Double
    let latitude: Double
    let timezoneIdentifier: String

    private enum CodingKeys: String, CodingKey {
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
}
