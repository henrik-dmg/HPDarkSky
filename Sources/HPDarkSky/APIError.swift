//
//  APIError.swift
//  
//
//  Created by Henrik Panhans on 08.08.19.
//

import Foundation

internal struct APIError: Codable, Equatable {
    let code: Int
    let error: String

    internal func makeNSError() -> NSError {
        return NSError(description: error, code: code)
    }
}
