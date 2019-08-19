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

public class MinutelyDatapoint: Codable, Equatable {
    public static func == (lhs: MinutelyDatapoint, rhs: MinutelyDatapoint) -> Bool {
        return (lhs.time == rhs.time && lhs.precipitation == rhs.precipitation)
    }
    
    ///The UNIX time at which this data point begins. minutely data point are always aligned to the top of the minute,
    ///hourly data point objects to the top of the hour,
    ///and daily data point objects to midnight of the day, all according to the local time zone.
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
