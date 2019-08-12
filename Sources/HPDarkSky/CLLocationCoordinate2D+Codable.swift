//
//  CLLocationCoordinate2D+Codable.swift
//  
//
//  Created by Henrik Panhans on 06.08.19.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Codable, Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
    enum CodingKeys: String, CodingKey {
        case longitude
        case latitude
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(longitude, forKey: .longitude)
        try container.encode(latitude, forKey: .latitude)
    }

    public init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        longitude = try container.decode(Double.self, forKey: .longitude)
        latitude = try container.decode(Double.self, forKey: .latitude)
    }

    public static func decode(from decoder: Decoder) throws -> CLLocationCoordinate2D {
        let locationContainer = try decoder.container(keyedBy: CodingKeys.self)
        return CLLocationCoordinate2D(
            latitude: try locationContainer.decode(Double.self, forKey: .latitude),
            longitude: try locationContainer.decode(Double.self, forKey: .longitude))

    }

    public static func validated(latitude: Double, longitude: Double) -> CLLocationCoordinate2D? {
        guard latitude.isValidLatitude && longitude.isValidLongitude else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    public var isValidLocation: Bool {
        return latitude.isValidLatitude && longitude.isValidLongitude
    }
}

public extension Double {
    var isValidLatitude: Bool {
        return (-90.00...90.000).contains(self)
    }

    var isValidLongitude: Bool {
        return (-180.00...180.00).contains(self)
    }
}
