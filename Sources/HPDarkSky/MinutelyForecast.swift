//
//  MinutelyForecast.swift
//  
//
//  Created by Henrik Panhans on 08.08.19.
//

import Foundation

public class MinutelyForecast: BasicForecast {
    public let datapoints: [MinutelyDatapoint]

    enum MinutelyCodingKeys: String, CodingKey {
        case datapoints = "data"
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MinutelyCodingKeys.self)
        self.datapoints = try container.decode([MinutelyDatapoint].self, forKey: .datapoints)

        try super.init(from: decoder)
    }
}

public class MinutelyDatapoint: Codable {
    public let time: Date
    public let precipitation: Precipitation

    enum CodingKeys: String, CodingKey {
        case time
        case precipitation
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.time = try container.decode(Date.self, forKey: .time)
        self.precipitation = try Precipitation.decode(from: decoder)
    }
}
