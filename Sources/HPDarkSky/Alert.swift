//
//  Alert.swift
//  
//
//  Created by Henrik Panhans on 09.08.19.
//

import Foundation

/// Type holding information about weather alerts such as thunderstorms
public struct Alert: Codable, Equatable {
    ///A brief description of the alert
    public let title: String
    ///The time at which the alert was issues
    public let timeStamp: Date
    ///The UNIX time at which the alert will expire.
    public let expires: Date
    ///A detailed description of the alert.
    public let description: String
    ///A URL that one may refer to for detailed information about the alert.
    public let url: URL
    ///An array of strings representing the names of the regions covered by this weather alert.
    public let affectedRegions: [String]
    ///The severity of the weather alert
    public let severity: AlertSeverity

    public var isExpired: Bool {
        return expires.timeIntervalSinceNow < 0.00
    }

    private enum CodingKeys: String, CodingKey {
        case title
        case timeStamp = "time"
        case expires
        case description
        case url = "uri"
        case affectedRegions = "regions"
        case severity
    }
}

/// Enum specifying the severity of a weather alert
public enum AlertSeverity: String, Codable, Equatable {
    ///An individual should be aware of potentially severe weather
    case advisory
    ///An individual should prepare for potentially severe weather
    case watch
    ///An individual should take immediate action to protect themselves and others from potentially severe weather
    case warning

    public static func severity(for dangerLevel: Int) -> AlertSeverity? {
        guard (1...3).contains(dangerLevel) else {
            return nil
        }
        switch dangerLevel {
        case 1:
            return .advisory
        case 2:
            return .watch
        case 3:
            return .warning
        default:
            return nil
        }
    }

    public var dangerLevel: Int {
        switch self {
        case .advisory:
            return 1
        case .watch:
            return 2
        case .warning:
            return 3
        }
    }
}

#if canImport(UIKit)
import UIKit

@available(iOS 13, tvOS 13, *)
public extension AlertSeverity {

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
        let iconName: String
        switch self {
        case .advisory:
            iconName = "info.circle"
        case .watch:
            iconName = "eye"
        case .warning:
            iconName = "exclamationmark.triangle"
        }

        return filled
            ? UIImage(systemName: iconName + ".fill", compatibleWith: traitCollection)!
            : UIImage(systemName: iconName, compatibleWith: traitCollection)!
    }

}
#endif
