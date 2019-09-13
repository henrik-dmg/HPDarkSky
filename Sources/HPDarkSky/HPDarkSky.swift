import Foundation
import CoreLocation

///A type which can conveniently request and handle weather data
public final class HPDarkSky {

    ///A shared weather client
    public static let shared = HPDarkSky(secret: nil)
    ///The attribution URL required by DarkSky
    public static let attributionURL = URL(string: "https://darksky.net/poweredby/")!
    ///The language used in the request response
    public var language: Language = .english
    ///The units used to format the request response
    public var units: WeatherUnits = .metric
    ///The API secret needed to make requests, obtain one [here](https://darksky.net/dev/register)
    public var secret: String?

    public init(secret: String?, language: Language = .english, units: WeatherUnits = .metric) {
        self.secret = secret
        self.language = language
        self.units = units
    }

    /// Performs a pre-specified request and returns the result
    /// - Parameter request: The request that will be used to fetch weather data
    /// - Parameter completion: The completion handler which returns an error or forecast
    public func performRequest(_ request: DarkSkyRequest, completion: @escaping (DarkSkyResponse?, Error?) -> Void) {
        hitEndpoint(with: request, completion: completion)
    }

    /// Requests the weather forecast for the specified location
    /// - Parameter location: The location the weather is requested for
    /// - Parameter excludedFields: The fields that will be excluded from the request
    /// - Parameter date: The timestamp for the request, can either be in the future or in the past (default is current)
    /// - Parameter completion: The completion handler which returns an error or forecast
    public func requestWeather(forLocation location: CLLocationCoordinate2D, excludedFields: [ExcludableFields] = [], date: Date? = nil, completion: @escaping (DarkSkyResponse?, Error?) -> Void) {
        guard let secret = self.secret else {
            completion(nil, NSError.missingSecret)
            return
        }

        let request = DarkSkyRequest(secret: secret, location: location, date: date, excludedFields: excludedFields)
        hitEndpoint(with: request, completion: completion)
    }

    ///Internal method for networking
    private func hitEndpoint(with request: DarkSkyRequest, completion: @escaping (DarkSkyResponse?, Error?) -> Void) {
        guard request.location.isValidLocation, let url = request.makeURL() else {
            completion(nil, NSError.invalidLocation)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let json = data, error == nil else {
                completion(nil, error)
                return
            }

            do {
                let decoder = JSONDecoder()
                //decoder.dateDecodingStrategy = .secondsSince1970

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

// Felt cute, will delete later
extension Data {
    func json() -> [String: Any]? {
        let model = try? JSONSerialization.jsonObject(with: self, options: [])

        if let json = model as? [String: Any] {
            return json
        }

        return nil
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
