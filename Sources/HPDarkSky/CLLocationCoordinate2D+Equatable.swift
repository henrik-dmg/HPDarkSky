//
//  CLLocationCoordinate2D+Codable.swift
//  
//
//  Created by Henrik Panhans on 06.08.19.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return (lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude)
    }
}

public extension CLLocationCoordinate2D {
    /// Returns a 'safe' CLLocationCoordinate2D. `Nil` will be returned if either longitude or latitude are out of bounds
    /// - Parameter latitude: The latitude passed into the coordinate instance
    /// - Parameter longitude: The longitude passed into the coordinate instance
    static func validated(latitude: Double, longitude: Double) -> CLLocationCoordinate2D? {
        guard latitude.isValidLatitude && longitude.isValidLongitude else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    ///Boolean indicating whether the initialised coordinates are valid
    var isValidLocation: Bool {
        return latitude.isValidLatitude && longitude.isValidLongitude
    }
}

public extension Double {
    ///Boolean indicating whether or not the value would be a valid latitude
    var isValidLatitude: Bool {
        return (-90.00...90.000).contains(self)
    }

    ///Boolean indicating whether or not the value would be a valid longitude
    var isValidLongitude: Bool {
        return (-180.00...180.00).contains(self)
    }
}
