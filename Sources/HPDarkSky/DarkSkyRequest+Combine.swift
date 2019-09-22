//
//  File.swift
//  
//
//  Created by Henrik Panhans on 16.09.19.
//

#if canImport(Combine)
import Foundation
import Combine

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension URLSession {
    ///Returns a new datatask publisher, using the passed in request
    func dataTaskPublisher(for request: DarkSkyRequest) -> URLSession.DataTaskPublisher {
        return self.dataTaskPublisher(for: request.makeURL())
    }
}
#endif
