//
//  Wind.swift
//  
//
//  Created by Henrik Panhans on 07.08.19.
//

import Foundation

///Type holding information about the wind, such as speed, bearing and gust
public struct Wind: Equatable {
    public let speed: Double
    public let gust: Double
    public let bearing: Int?
    public let gustTime: Date?
}
