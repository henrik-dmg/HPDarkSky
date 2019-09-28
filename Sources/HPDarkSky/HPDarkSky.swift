import Foundation
import CoreLocation

///Type that handles making requests and decoding the returned response into a usable format
public final class HPDarkSky {

    ///Typealias for an optional forecast and error returned by the API
    public typealias APIResponse = (DarkSkyResponse?, Error?) -> Void

    ///A shared weather client, with the secret defaulting to nil
    public static let shared = HPDarkSky(secret: nil)
    ///The attribution URL required by DarkSky
    public static let attributionURL = URL(string: "https://darksky.net/poweredby/")!
    ///The language used in the request response
    public var language: Language = .english
    ///The units used to format the request response
    public var units: WeatherUnits = .metric
    ///The API secret needed to make requests, obtain one [here](https://darksky.net/dev/register)
    public var secret: String?

    /// Inits a new weather client with the passed in properties
    /// - Parameter secret: The DarkSky API secret key required to get a response
    /// - Parameter units: The units that should be used to format the data in the response
    /// - Parameter language: The language that should be used in the response, e.g. for daily summaries
    public init(secret: String?, language: Language = .english, units: WeatherUnits = .metric) {
        self.secret = secret
        self.language = language
        self.units = units
    }

    /// Performs a pre-specified request and returns the result
    /// - Parameter request: The request that will be used to fetch weather data
    /// - Parameter completion: The completion handler which returns an error or forecast
    public func performRequest(_ request: DarkSkyRequest, completion: @escaping APIResponse) {
        hitEndpoint(with: request, completion: completion)
    }

    /// Requests the weather forecast for the specified location
    /// - Parameter location: The location the weather is requested for
    /// - Parameter excludedFields: The fields that will be excluded from the request
    /// - Parameter date: The timestamp for the request,
    /// can either be in the future or in the past (default is current)
    /// - Parameter completion: The completion handler which returns an error or forecast
    public func requestWeather(forLocation location: CLLocationCoordinate2D, excludedFields: [ExcludableFields] = [], date: Date? = nil, completion: @escaping APIResponse) {
        guard let secret = self.secret else {
            completion(nil, NSError.missingSecret)
            return
        }

        let request = DarkSkyRequest(secret: secret, location: location, date: date, excludedFields: excludedFields)
        hitEndpoint(with: request, completion: completion)
    }

    ///Internal method for networking
    private func hitEndpoint(with request: DarkSkyRequest, completion: @escaping APIResponse) {
        guard request.location.isValidLocation else {
            completion(nil, NSError.invalidLocation)
            return
        }

        URLSession.shared.dataTask(with: request.makeURL()) { data, _, error in
            guard let json = data, error == nil else {
                completion(nil, error)
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970

                if let apiError = try? decoder.decode(APIError.self, from: json) {
                    completion(nil, apiError.makeNSError())
                    return
                }

                let forecast = try decoder.decode(DarkSkyResponse.self, from: json)

                completion(forecast, error)
            } catch let parsingError {
                completion(nil, parsingError)
            }
        }.resume()
    }

}

internal extension NSError {
    convenience init(description: String, code: Int = 1) {
        self.init(
            domain: "com.henrikpanhans.HPDarkSky",
            code: code,
            userInfo: [NSLocalizedDescriptionKey: description])
    }

    static let missingSecret = NSError(description: "No API secret was found")
    static let invalidLocation = NSError(description: "The specified location was invalid", code: 69)
}
