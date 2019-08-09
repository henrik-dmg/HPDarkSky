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
        XCTAssertNotNil(TestSecret.secret, "Secret was apparently not set as env variable")
    }

    func testCrazyLocation() {
        let crazyLocation = CLLocationCoordinate2D(latitude: 200, longitude: 300)
        let goodLocation = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        XCTAssertFalse(crazyLocation.isValidLocation)
        XCTAssertTrue(goodLocation.isValidLocation)
    }

    func testExcludingAll() {
        var request = makeRequestObject()
        request.excludedFields = ExcludableFields.allCases
        let exp = expectation(description: "fetched empty forecast from server")

        HPDarkSky.shared.performRequest(request) { (forecast, error) in
            guard let forecast = forecast else {
                XCTFail("No forecast returned")
                exp.fulfill()
                return
            }
            XCTAssertNil(forecast.currently)
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
                XCTFail("No forecast returned")
                XCTAssertNil(error, "Error was not nil, description: \(error!.localizedDescription)")
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
        "testCrazyLocation": testCrazyLocation
    ]
}
