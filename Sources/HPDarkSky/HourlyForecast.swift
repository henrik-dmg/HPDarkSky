//
//  File.swift
//  
//
//  Created by Henrik Panhans on 10.08.19.
//

import Foundation

public class HourlyForecast: Forecast {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}
