//
//  MinutelyForecast.swift
//  
//
//  Created by Henrik Panhans on 08.08.19.
//

import Foundation

public class MinutelyForecast: Forecast {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}
