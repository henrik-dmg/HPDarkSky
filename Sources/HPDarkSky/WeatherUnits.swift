import Foundation

///Enum used to specify the units used in the API response to forma the data
public enum WeatherUnits: String, Codable, Equatable {
    ///Imperial units such as miles, feet and inches and Fahrenheit
    case imperial = "us"
    ///Metric units such as kilometers, centimeter and Celsius
    case metric = "si"

    ///Do I really need to explain why this defaults to metric?
    public static let `default`: WeatherUnits = .metric
}
