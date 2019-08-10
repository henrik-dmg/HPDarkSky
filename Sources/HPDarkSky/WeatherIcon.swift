//
//  WeatherIcon.swift
//  
//
//  Created by Henrik Panhans on 10.08.19.
//

import Foundation

public enum WeatherIcon: String, Codable {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case cloudy
    case rain
    case sleet
    case snow
    case wind
    case fog
}

#if os(iOS) || os(tvOS)
import UIKit

@available(iOS 13, tvOS 13, *)
public extension WeatherIcon {
    @available(iOS 13, tvOS 13, *)
    func filledIcon(compatibleWith traitCollection: UITraitCollection?) -> UIImage {
        return makeIcon(filled: true, compatibleWith: traitCollection)
    }

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
        }

        if filled { iconName.append(".fill") }

        return UIImage(systemName: iconName, compatibleWith: traitCollection)!
    }
}
#endif
