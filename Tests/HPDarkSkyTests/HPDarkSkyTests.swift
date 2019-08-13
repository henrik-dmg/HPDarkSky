import XCTest
import CoreLocation
@testable import HPDarkSky

final class HPDarkSkyTests: XCTestCase {

    func makeRequestObject() -> DarkSkyRequest {
        guard let envSecret = TestSecret.secret else {
            fatalError("Could not find secret")

        }
        return DarkSkyRequest(
            secret: envSecret,
            location: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            excludedFields: [])
    }

    func testSecretExistsInEnvironment() {
        XCTAssertNotNil(TestSecret.secret, "Secret was not set as env variable")
    }

    func testCrazyLocation() {
        let crazyLocation = CLLocationCoordinate2D(latitude: 200, longitude: 300)
        let anotherCrazyLocaiton = CLLocationCoordinate2D.validated(latitude: 200, longitude: 300)
        let goodLocation = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        XCTAssertFalse(crazyLocation.isValidLocation, "Location was falsely evaluated as valid")
        XCTAssertNil(anotherCrazyLocaiton, "Should not init with invalid coordinates")
        XCTAssertTrue(goodLocation.isValidLocation, "Location was falsely evaluated as invalid")
    }
    
//    func testCodableModel() {
//        var request = makeRequestObject()
//        request.excludedFields = ExcludableFields.allCases
//        let exp = expectation(description: "fetched forecast from server")
//
//        let test = DarkSkyResponse.test
//        HPDarkSky.shared.performRequest(request) { forecast, error in
//            guard let forecast = forecast else {
//                XCTAssertNil(error, "Error was not nil, description: \(error!.localizedDescription)")
//                XCTFail("No forecast returned")
//                exp.fulfill()
//                return
//            }
//
//            do {
//                let encoder = JSONEncoder()
//                encoder.dateEncodingStrategy = .secondsSince1970
//                let data = try encoder.encode(forecast)
//
//                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .secondsSince1970
//                let newForecast = try decoder.decode(DarkSkyResponse.self, from: data)
//                XCTAssertEqual(forecast, newForecast)
//            } catch {
//                XCTFail("Could not decode or encode forecast object")
//            }
//        }
//    }

    func testExcludingAll() {
        var request = makeRequestObject()
        request.excludedFields = ExcludableFields.allCases
        let exp = expectation(description: "fetched empty forecast from server")

        HPDarkSky.shared.performRequest(request) { (forecast, error) in
            guard let forecast = forecast else {
                XCTAssertNil(error, "Error was not nil, description: \(error!.localizedDescription)")
                XCTFail("No forecast returned")
                exp.fulfill()
                return
            }
            XCTAssertNil(forecast.currently, "Current weather not excluded")
            XCTAssertNil(forecast.minutely, "Minutely forecast not excluded")
            XCTAssertNil(forecast.hourly, "Hourly forecast not excluded")
            XCTAssertNil(forecast.daily, "Daily forecast not excluded")
            XCTAssertNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testBasicRequest() {
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
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    static var allTests = [
        "testSecretExistsInEnvironment": testSecretExistsInEnvironment,
        "testBasicRequest": testBasicRequest,
        "testExcludingCurrently": testExcludingAll,
        "testCrazyLocation": testCrazyLocation,
        //"testCodableModel": testCodableModel
    ]
}
