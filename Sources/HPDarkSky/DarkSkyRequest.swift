//
//  DarkSkyRequest.swift
//  
//
//  Created by Henrik Panhans on 06.08.19.
//

import Foundation
import CoreLocation

///A request object to use with your own networking
public struct DarkSkyRequest {
    ///An array of fields to be excluded in the response
    public var excludedFields = [ExcludableFields]()
    ///The location to request weather data for
    public var location: CLLocationCoordinate2D!
    ///The language to be used in the response's summary texts
    public var language: Language = .english
    ///The units to be used in the response's data
    public var units: Units = .metric
    ///An optional date to perform a Time Machine request
    public var date: Date?
    ///The required API secret
    private let secret: String

    public init(secret: String, location: CLLocationCoordinate2D, date: Date? = nil, excludedFields: [ExcludableFields] = []) {
        self.secret = secret
        self.date = date
        self.excludedFields = excludedFields
        self.location = location
    }

    ///Constructs the URL to request
    internal func makeURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.darksky.net"
        components.path = makeURLPath()
        components.queryItems = makeQueryItems()
        return components.url
    }

    ///Construct the URL path with the API secret, location and if applicable the date in seconds since epoch
    private func makeURLPath() -> String {
        var basePath = "/forecast/\(secret)/\(location.latitude),\(location.longitude)"
        if let date = date {
            basePath.append("\(date.timeIntervalSince1970)")
        }
        return basePath
    }

    ///Constructs the additional query items, such as units, excluded fields and language
    private func makeQueryItems() -> [URLQueryItem] {
        var items = [URLQueryItem]()
        if !excludedFields.isEmpty {
            let excludedItem = URLQueryItem(name: "exclude", value: excludedFields.compactMap({$0.rawValue}).joined(separator: ","))
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
}

// TODO:
public extension URLSession {
    func dataTask(with request: DarkSkyRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: request.makeURL()!, completionHandler: completionHandler)
    }
}
