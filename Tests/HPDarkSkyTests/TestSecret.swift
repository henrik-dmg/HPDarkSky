//
//  File.swift
//  
//
//  Created by Henrik Panhans on 08.08.19.
//

import Foundation

struct TestSecret {
    static let secret: String? = ProcessInfo.processInfo.environment["TEST_SECRET"]
}
