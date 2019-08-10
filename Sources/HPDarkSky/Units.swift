//
//  File.swift
//  
//
//  Created by Henrik Panhans on 06.08.19.
//

import Foundation

public enum Units: String, Codable {
    case imperial = "us"
    case metric = "si"

    public static let `default`: Units = .metric
}
