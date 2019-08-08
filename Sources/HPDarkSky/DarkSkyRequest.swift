//
//  DarkSkyRequest.swift
//  
//
//  Created by Henrik Panhans on 06.08.19.
//

import Foundation
import CoreLocation

public struct DarkSkyRequest {
    internal static let baseURL = URL(string: "https://api.darksky.net/forecast")!
    public var excludedFields = [ExcludableFields]()
    public var location: CLLocationCoordinate2D!
    public var language: Language = .english
    public var units: Units = .metric
    private let secret: String
    
    public init(secret: String, location: CLLocationCoordinate2D, excludedFields: [ExcludableFields] = []) {
        self.secret = secret
        self.excludedFields = excludedFields
        self.location = location
    }
    
    public func constructURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.darksky.net"
        components.path = "/forecast/\(secret)/\(location.latitude),\(location.longitude)"
        components.queryItems = makeQueryItems()
        
        return components.url
    }
    
    private func makeQueryItems() -> [URLQueryItem] {
        var items = [URLQueryItem]()
        if !excludedFields.isEmpty {
            let excludedItem = URLQueryItem(name: "excluded", value: excludedFields.compactMap({$0.rawValue}).joined(separator: ","))
            items.append(excludedItem)
        }
        
        items.append(URLQueryItem(name: "lang", value: language.rawValue))
        items.append(URLQueryItem(name: "units", value: units.rawValue))
        
        return items
    }
}

public enum ExcludableFields: String, RawRepresentable, CaseIterable {
    case currently
    case minutely
    case hourly
    case daily
    case alerts
    case flags
}

// TODO:
public extension URLSession {
    func dataTask(with request: DarkSkyRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: request.constructURL()!, completionHandler: completionHandler)
    }
}
