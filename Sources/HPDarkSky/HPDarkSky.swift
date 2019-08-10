import Foundation
import CoreLocation

public final class HPDarkSky {

    public static let shared = HPDarkSky(secret: nil)
    public static let attributionURL = URL(string: "https://darksky.net/poweredby/")!
    public var language: Language = .english
    public var units: Units = .metric
    public var secret: String?

    public init(secret: String?, language: Language = .english, units: Units = .metric) {
        self.secret = secret
        self.language = language
        self.units = units
    }

    public func performRequest(_ request: DarkSkyRequest, completion: @escaping (DarkSkyResponse?, Error?) -> Void) {
        hitEndpoint(with: request, completion: completion)
    }

    public func requestWeather(forLocation location: CLLocationCoordinate2D, excludedFields: [ExcludableFields] = [], pastDate: Date? = nil, completion: @escaping (DarkSkyResponse?, Error?) -> Void) {
        guard let secret = self.secret else {
            completion(nil, NSError.missingSecret)
            return
        }

        if let pastDate = pastDate {
            if pastDate.timeIntervalSinceNow > 0.00 {
                completion(nil, NSError.invalidRequestDate)
            }
            return
        }
        let request = DarkSkyRequest(secret: secret, location: location, excludedFields: excludedFields)
        hitEndpoint(with: request, completion: completion)
    }

    private func hitEndpoint(with request: DarkSkyRequest, completion: @escaping (DarkSkyResponse?, Error?) -> Void) {
        guard request.location.isValidLocation else {
            completion(nil, NSError.invalidLocation)
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
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
    static let invalidRequestDate = NSError(description: "The specified time machine request was in the future", code: 420)
}
