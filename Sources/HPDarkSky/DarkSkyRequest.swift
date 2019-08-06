//
//  DarkSkyRequest.swift
//  
//
//  Created by Henrik Panhans on 06.08.19.
//

import Foundation
import CoreLocation

public struct DarkSkyRequest {
    internal static let baseURL = URL(string: "https://api.darksky.net/forecast")!
    public let excludedFields: [ExcludableFields]
    public let location: CLLocationCoordinate2D
    
    public init(location: CLLocationCoordinate2D, excludedFields: [ExcludableFields] = []) {
        self.excludedFields = excludedFields
        self.location = location
    }
}

public enum ExcludableFields: String {
    case currently
    case minutely
    case hourly
    case daily
    case alerts
    case flags
}

// TODO:
//public extension URLSession {
//    func dataTask(with: DarkSkyRequest) {
//
//    }
//}
