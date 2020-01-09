import Foundation

/// An enum providing native system icons based on the API response
public enum WeatherIcon: String, Codable, CaseIterable {
    ///Clear conditions during daytime
    case clearDay = "clear-day"
    ///Clear conditions during nighttime
    case clearNight = "clear-night"
    ///Partly cloudy conditions during daytime
    case partlyCloudyDay = "partly-cloudy-day"
    ///Partly cloudy conditions during nighttime
    case partlyCloudyNight = "partly-cloudy-night"
    ///Cloudy conditions
    case cloudy
    ///Rainy conditions
    case rain
    ///Sleety conditions
    case sleet
    ///Snowy conditions
    case snow
    ///Windy conditions
    case wind
    ///Foggy conditions
    case fog
    ///Hailing conditions
    case hail
    ///A thunderstorm
    case thunderstorm
    ///A tornado, who would have thought that
    case tornado
}

#if os(iOS) || os(tvOS)
import UIKit

@available(iOS 13, tvOS 13, *)
public extension WeatherIcon {
    ///Returns a filled icon from the SF Symbols library
    @available(iOS 13, tvOS 13, *)
    func filledIcon(compatibleWith traitCollection: UITraitCollection?) -> UIImage {
        return makeIcon(filled: true, compatibleWith: traitCollection)
    }

    ///Returns a hollow/line icon from the SF Symbols library
    @available(iOS 13, tvOS 13, *)
    func hollowIcon(compatibleWith traitCollection: UITraitCollection?) -> UIImage {
        return makeIcon(filled: false, compatibleWith: traitCollection)
    }

    @available(iOS 13, tvOS 13, *)
    private func makeIcon(filled: Bool, compatibleWith traitCollection: UITraitCollection?) -> UIImage {
        var iconName = ""
        switch self {
        case .clearDay:
            iconName = "sun.max"
        case .clearNight:
            iconName = "moon"
        case .partlyCloudyDay:
            iconName = "cloud.sun"
        case .partlyCloudyNight:
            iconName = "cloud.moon"
        case .cloudy:
            iconName = "cloud"
        case .rain:
            iconName = "cloud.rain"
        case .sleet:
            iconName = "cloud.sleet"
        case .snow:
            iconName = "cloud.snow"
        case .wind:
            return UIImage(systemName: "wind")!
        case .fog:
            iconName = "cloud.fog"
        case .hail:
            iconName = "cloud.hail"
        case .thunderstorm:
            iconName = "cloud.bolt"
        case .tornado:
            return UIImage(systemName: "tornado")!
        }

        if filled { iconName.append(".fill") }

        return UIImage(systemName: iconName, compatibleWith: traitCollection)!
    }
}
#endif
