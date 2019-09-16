//
//  File.swift
//  
//
//  Created by Henrik Panhans on 16.09.19.
//

#if canImport(Combine)
import Foundation
import Combine

@available(iOS 13, tvOS 13, *)
extension URLSession {
    func dataTaskPublisher(for request: DarkSkyRequest) -> URLSession.DataTaskPublisher {
        return self.dataTaskPublisher(for: request.makeURL())
    }
}
#endif
