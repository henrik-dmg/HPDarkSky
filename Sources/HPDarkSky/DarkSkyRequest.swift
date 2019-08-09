//
//  DarkSkyRequest.swift
//  
//
//  Created by Henrik Panhans on 06.08.19.
//

import Foundation
import CoreLocation

public struct DarkSkyRequest {
    private static let baseURL = URL(string: "https://api.darksky.net/forecast")!

    public var excludedFields = [ExcludableFields]()
    public var location: CLLocationCoordinate2D!
    public var language: Language = .english
    public var units: Units = .metric
    public var date: Date?
    private let secret: String

    public init(secret: String, location: CLLocationCoordinate2D, date: Date? = nil, excludedFields: [ExcludableFields] = []) {
        self.secret = secret
        self.date = date
        self.excludedFields = excludedFields
        self.location = location
    }

    internal func makeURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.darksky.net"
        components.path = makeURLPath()
        components.queryItems = makeQueryItems()
        return components.url
    }

    private func makeURLPath() -> String {
        var basePath = "/forecast/\(secret)/\(location.latitude),\(location.longitude)"
        if let date = date {
            basePath.append("\(date.timeIntervalSince1970)")
        }
        return basePath
    }

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
