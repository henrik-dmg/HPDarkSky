import Foundation
import CoreLocation

public final class HPDarkSky {

    public static let shared = HPDarkSky(secret: nil)

    public var language: Language = .english
    public var units: Units = .metric
    public var secret: String?

    public init(secret: String?, language: Language = .english, units: Units = .metric) {
        self.secret = secret
        self.language = language
        self.units = units
    }
    
    public func performRequest(_ request: DarkSkyRequest, completion: @escaping (Forecast?, Error?) -> Void) {
        guard let secret = secret else {
            completion(nil, NSError.missingSecret as Error)
            return
        }
        
        let url = buildURL(for: secret, location: request.location)
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let json = data, error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970

                #if DEBUG
                print(json.json())
                #endif
                
                let forecast = try decoder.decode(Forecast.self, from: json)

                completion(forecast, error)
            } catch let parsingError {
                completion(nil, parsingError)
            }
        }.resume()
    }
    
    internal func buildURL(for secret: String, location: CLLocationCoordinate2D, excludedFields: [ExcludableFields]? = nil) -> URL {
        var baseURL = DarkSkyRequest.baseURL
        baseURL.appendPathComponent(secret)
        baseURL.appendPathComponent("\(location.latitude),\(location.longitude)")

        return baseURL
    }
    
    /**
     Private function to actually make the API calls
     
     - Parameters:
        - url: The completete the GET request is sent to
        - completion: Completion block that is called when the network call is completed
        - json: Dictionary containing the response in JSON format
        - error: An error object that indicates why the request failed, or nil if the request was successful.
    */
//    private func request<T: Codable>(url: inout URL, for type: T.Type, completion: @escaping (_ data: T?, _ error: Error?) -> ()) {
//        let values = Array(self.params.values)
//        url.add(values)
//        let urlRequest = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            guard let json = data, error == nil else {
//                completion(nil, error)
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .secondsSince1970
//
//                if let apiError = try? decoder.decode(APIError.self, from: json) {
//                    completion(nil, apiError.nserror)
//                    return
//                }
//
//                let model = try decoder.decode(type, from: json)
//
//                completion(model, error)
//            } catch let parsingError {
//                completion(nil, parsingError)
//            }
//        }.resume()
//    }
}

extension Data {
    func json() -> [String:Any]? {
        let model = try? JSONSerialization.jsonObject(with: self, options: [])

        if let json = model as? [String:Any] {
            return json
        }
        
        return nil
    }
}

private extension NSError {
    convenience init(description: String) {
        self.init(
            domain: "com.henrikpanhans.HPDarkSky",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    static let missingSecret = NSError(description: "No API secret was found")
}
