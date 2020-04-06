import XCTest
import CoreLocation
@testable import HPDarkSky

final class HPDarkSkyTests: XCTestCase {

    func makeRequestObject() -> DarkSkyRequest {
        return DarkSkyRequest(
            secret: TestSecret.secret!,
            location: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            date: Date(),
            excludedFields: [],
            units: .metric,
            language: .bengali)
    }

    let badRequest = DarkSkyRequest(
        secret: TestSecret.secret!,
        location: CLLocationCoordinate2D(latitude: 200, longitude: 300),
        date: Date.distantFuture,
        excludedFields: [],
        units: .imperial,
        language: .english)

    func testSecretExistsInEnvironment() {
        XCTAssertNotNil(TestSecret.secret, "Secret was not set as env variable")
    }

    func testMakeAPIError() {
        let error = APIError(code: 420, error: "Some error message")

        XCTAssertEqual(error.makeNSError().code, 420)
    }

    func testCrazyLocation() {
        let crazyLocation = CLLocationCoordinate2D(latitude: 200, longitude: 300)
        let anotherCrazyLocaiton = CLLocationCoordinate2D.validated(latitude: 200, longitude: 300)
        let goodLocation = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        XCTAssertFalse(crazyLocation.isValidLocation, "Location was falsely evaluated as valid")
        XCTAssertNil(anotherCrazyLocaiton, "Should not init with invalid coordinates")
        XCTAssertTrue(goodLocation.isValidLocation, "Location was falsely evaluated as invalid")
        XCTAssertNil(CLLocationCoordinate2D.validated(latitude: 20000, longitude: 20000))
        XCTAssertNotNil(CLLocationCoordinate2D.validated(latitude: 37.7749, longitude: -122.4194))
        XCTAssertFalse(crazyLocation == goodLocation)
    }

    func testExcludingAll() {
        let request = DarkSkyRequest(
            secret: TestSecret.secret!,
            location: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            date: Date(),
            excludedFields: ExcludableFields.allCases,
            units: .metric,
            language: .bengali)
        let exp = expectation(description: "fetched empty forecast from server")

        HPDarkSky.shared.performRequest(request) { result in
            guard let forecast = try? result.get() else {
                XCTFail("No forecast returned")
                exp.fulfill()
                return
            }
            XCTAssertNil(forecast.currently, "Current weather not excluded")
            XCTAssertNil(forecast.minutely, "Minutely forecast not excluded")
            XCTAssertNil(forecast.hourly, "Hourly forecast not excluded")
            XCTAssertNil(forecast.daily, "Daily forecast not excluded")
            exp.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }

    func testBasicRequest() {
        let request = makeRequestObject()
        let exp = expectation(description: "fetched current data from server")

        HPDarkSky.shared.performRequest(request) { result in
            guard let forecast = try? result.get() else {
                XCTFail("No forecast returned")
                exp.fulfill()
                return
            }
            XCTAssertNotNil(forecast.currently, "Current weather is missing")
            XCTAssertNotNil(forecast.minutely, "Minutely forecast is missing")
            XCTAssertNotNil(forecast.hourly, "Hourly forecast is missing")
            XCTAssertNotNil(forecast.daily, "Daily forecast is missing")
            exp.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }

    func testURLSessionExtension() {
        let exp = expectation(description: "fetched current data from server")

        URLSession.shared.dataTask(with: makeRequestObject()) { data, response, error in
            exp.fulfill()
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
        }?.resume()

        waitForExpectations(timeout: 20, handler: nil)
    }

    func testBadRequestFailing() {
        let exp = expectation(description: "Retrieve no data")

        HPDarkSky.shared.performRequest(badRequest) { result in
            exp.fulfill()

            if case .failure(let err) = result {
                XCTAssert(err as NSError == NSError.invalidLocation)
            } else {
                XCTFail("Could not unwrap error")
            }
        }

        waitForExpectations(timeout: 20, handler: nil)
    }

    func testFactoryMethod() {
        let exp = expectation(description: "fetched current data from server")
        let location = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        HPDarkSky.shared.secret = TestSecret.secret!
        HPDarkSky.shared.requestWeather(forLocation: location) { result in
            guard let forecast = try? result.get() else {
                XCTFail("No forecast returned")
                exp.fulfill()
                return
            }
            XCTAssertNotNil(forecast.currently, "Current weather is missing")
            XCTAssertNotNil(forecast.minutely, "Minutely forecast is missing")
            XCTAssertNotNil(forecast.hourly, "Hourly forecast is missing")
            XCTAssertNotNil(forecast.daily, "Daily forecast is missing")
            XCTAssertEqual(forecast.location, location)
            HPDarkSky.shared.secret = nil
            exp.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }

    func testTimeMachineRequest() {
        let exp = expectation(description: "fetched current data from server")
        let location = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        let date = Date()
        HPDarkSky.shared.secret = TestSecret.secret!
        HPDarkSky.shared.requestWeather(forLocation: location, date: date) { result in
            guard let forecast = try? result.get() else {
                XCTFail("No forecast returned")
                exp.fulfill()
                return
            }
            XCTAssertNotNil(forecast.currently, "Current weather is missing")
            XCTAssertNotNil(forecast.minutely, "Minutely forecast is missing")
            XCTAssertNotNil(forecast.hourly, "Hourly forecast is missing")
            XCTAssertNotNil(forecast.daily, "Daily forecast is missing")
            XCTAssertEqual(forecast.location, location)
            XCTAssertEqual(forecast.currently?.time, date.removingMillisecondsFraction(), "Time was decoded incorrectly")
            HPDarkSky.shared.secret = nil
            exp.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }

    func testSecretNotSet() {
        let exp = expectation(description: "fetched current data from server")

        HPDarkSky.shared.requestWeather(forLocation: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)) { result in
            exp.fulfill()

            if case .failure(let err) = result {
                XCTAssert(err as NSError == NSError.missingSecret)
            } else {
                XCTFail("Could not unwrap error")
            }
        }

        waitForExpectations(timeout: 20, handler: nil)
    }

    static var allTests = [
        ("testSecretExistsInEnvironment", testSecretExistsInEnvironment),
        ("testCrazyLocation", testCrazyLocation),
        ("testBasicRequest", testBasicRequest),
        ("testExcludingAll", testExcludingAll),
        ("testBadRequestFailing", testBadRequestFailing),
        ("testFactoryMethod", testFactoryMethod),
        ("testSecretNotSet", testSecretNotSet)
    ]
}

public extension Date {
    func removingMillisecondsFraction() -> Date {
        return Date(timeIntervalSince1970: timeIntervalSince1970.rounded(.towardZero))
    }
}
