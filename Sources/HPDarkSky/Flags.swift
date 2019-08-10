//
//  Flags.swift
//  
//
//  Created by Henrik Panhans on 10.08.19.
//

import Foundation

struct Flags: Codable {
    let units: Units
    let sources: [String]
    let nearestStation: Double?

    enum CodingKeys: String, CodingKey {
        case units
        case sources
        case nearestStation
    }
}
