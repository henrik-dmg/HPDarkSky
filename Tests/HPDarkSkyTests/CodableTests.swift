import XCTest
import CoreLocation
@testable import HPDarkSky

final class CodableTests: XCTestCase {
    var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        return encoder
    }

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }

    func makeRequestObject() -> DarkSkyRequest {
        guard let envSecret = TestSecret.secret else {
            fatalError("Could not find secret")

        }
        return DarkSkyRequest(
            secret: envSecret,
            location: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            excludedFields: [])
    }

    func testAlertCodable() throws {
        let alert = Alert(
            title: "Mock",
            timeStamp: Date.distantPast,
            expires: Date.distantFuture,
            description: "Mock descriptio",
            url: URL(string: "https://google.com")!,
            affectedRegions: ["europe"],
            severity: .warning)

        let data = try encoder.encode(alert)
        let loaded = try decoder.decode(Alert.self, from: data)

        XCTAssertEqual(alert, loaded)
    }

    func testAPIErrorCodable() throws {
        let apiError = APIError(code: 401, error: "Some generic error")

        let data = try encoder.encode(apiError)
        let loaded = try decoder.decode(APIError.self, from: data)

        XCTAssertEqual(apiError, loaded)
    }

    func testCurrentDatapointCodable() {
        let current = CurrentDatapoint(temperature: 10.00, cloudCover: 10, dewPoint: 10, humidity: 10, icon: .clearDay, ozone: 10, pressure: 10, summary: "Generic description", time: Date.distantPast, uvIndex: 10, visibility: 10, windSpeed: 10, windGust: 10, windBearing: 10, windGustTime: Date(), precipIntensity: 10, precipIntensityError: nil, precipProbability: 10, precipType: .rain, precipIntensityMax: nil, precipIntensityMaxTime: nil, precipAccumulation: nil)

        do {
            let data = try encoder.encode(current)
            let loaded = try decoder.decode(CurrentDatapoint.self, from: data)
            XCTAssertEqual(current, loaded)
        } catch let err {
            XCTFail(err.localizedDescription)
        }
    }

    func testCodable() {
        let request = makeRequestObject()
        let exp = expectation(description: "fetched current data from server")

        HPDarkSky.shared.performRequest(request) { (forecast, error) in
            guard let forecast = forecast else {
                XCTAssertNil(error, "Error was not nil, description: \(error!.localizedDescription)")
                XCTFail("No forecast returned")
                exp.fulfill()
                return
            }
            XCTAssertNotNil(forecast.currently, "Current weather is missing")
            XCTAssertNotNil(forecast.minutely, "Minutely forecast is missing")
            XCTAssertNotNil(forecast.hourly, "Hourly forecast is missing")
            XCTAssertNotNil(forecast.daily, "Daily forecast is missing")
            XCTAssertNil(error)
            exp.fulfill()

//            do {
//                let data = try self.encoder.encode(forecast)
//                let loaded = try self.decoder.decode(DarkSkyResponse.self, from: data)
//                XCTAssertEqual(forecast, loaded)
//            } catch let err {
//                XCTFail(err.localizedDescription)
//            }
        }

        waitForExpectations(timeout: 20, handler: nil)
    }

    static var allTests = [
        ("testCurrentDatapointCodable", testCurrentDatapointCodable),
        ("testAPIErrorCodable", testAPIErrorCodable),
        ("testAlertCodable", testAlertCodable)
    ]
}
