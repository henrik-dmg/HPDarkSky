//
//  TimeZone+Codable.swift
//  
//
//  Created by Henrik Panhans on 09.08.19.
//

import Foundation

extension TimeZone {
    enum CodingKeys: String, CodingKey {
        case identifier = "timezone"
    }

    public static func decode(from decoder: Decoder) throws -> TimeZone {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let timeZone = TimeZone(identifier: try container.decode(String.self, forKey: .identifier)) else {
            throw NSError(description: "Could not instantiate timezone, likely API error", code: 2)
        }

        return timeZone
    }
}
