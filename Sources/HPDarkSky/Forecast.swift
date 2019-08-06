//
//  File.swift
//  
//
//  Created by Henrik Panhans on 06.08.19.
//

import Foundation
import CoreLocation

public struct Forecast: Codable {
    let location: CLLocationCoordinate2D
    let timezone: String
    let currently: CurrentWeather?
    
    enum CodingKeys: String, CodingKey {
        case location
        case timezone
        case currently
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.timezone = try container.decode(String.self, forKey: .timezone)
        self.currently = try container.decodeIfPresent(CurrentWeather.self, forKey: .currently)
        
        let locationContainer = try decoder.container(keyedBy: CLLocationCoordinate2D.CodingKeys.self)
        self.location = CLLocationCoordinate2D(
            latitude: try locationContainer.decode(Double.self, forKey: .latitude),
            longitude: try locationContainer.decode(Double.self, forKey: .longitude))
    }
}
