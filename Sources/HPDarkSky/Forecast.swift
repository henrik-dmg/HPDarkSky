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
}
