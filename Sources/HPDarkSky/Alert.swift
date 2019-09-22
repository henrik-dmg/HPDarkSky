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
}
