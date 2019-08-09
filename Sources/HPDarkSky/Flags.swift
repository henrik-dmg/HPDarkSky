//
//  Flags.swift
//  
//
//  Created by Henrik Panhans on 10.08.19.
//

import Foundation

struct Flags: Codable {
    let units: Units
    
    enum CodingKeys: String, CodingKey {
        case units
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.units = Units(rawValue: try container.decode(String.self, forKey: .units)) ?? .default
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(units.rawValue, forKey: .units)
    }
}
