//
//  APIError.swift
//  
//
//  Created by Henrik Panhans on 08.08.19.
//

import Foundation


struct APIError: Codable {
    let code: Int
    let error: String

    internal func makeNSError() -> NSError {
        return NSError(description: error, code: code)
    }
}
