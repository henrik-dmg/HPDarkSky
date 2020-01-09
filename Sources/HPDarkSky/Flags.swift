import Foundation

///The flags object contains various metadata information related to the request
public struct Flags: Codable, Equatable {
    ///Indicates the units which were used for the data in this request.
    public let units: WeatherUnits
    ///[data source]https://darksky.net/dev/docs/sources "See list of data sources"
    ///This property contains an array of IDs for each [data source] utilized in servicing this request.
    public let sources: [String]
    ///The distance to the nearest weather station that contributed data to this response.
    ///Note, however, that many other stations may have also been used; this value is primarily for debugging purposes.
    ///This property's value is in miles (if US units are selected) or kilometers (if SI units are selected).
    public let nearestStation: Double?
}
