//
//  MinutelyForecast.swift
//  
//
//  Created by Henrik Panhans on 08.08.19.
//

import Foundation

public class MinutelyForecast: BasicForecast {
    let datapoints: [BasicDatapoint]
    
    enum MinutelyCodingKeys: String, CodingKey {
        case datapoints = "data"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MinutelyCodingKeys.self)
        self.datapoints = try container.decode([BasicDatapoint].self, forKey: .datapoints)
        
        try super.init(from: decoder)
    }
}
