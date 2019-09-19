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

        waitForExpectations(timeout: 20, handler: nil)
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
            XCTAssertEqual(forecast.timezone, TimeZone.init(abbreviation: "PDT")!)
            XCTAssertNil(error)
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
        
        HPDarkSky.shared.performRequest(badRequest) { response, error in
            exp.fulfill()
            XCTAssertNil(response)
            
            do {
                let err: NSError = try XCTUnwrap(error) as NSError
                XCTAssert(err == NSError.invalidLocation)
            } catch let unwrapError {
                XCTFail(unwrapError.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testFactoryMethod() {
        let exp = expectation(description: "fetched current data from server")
        let location = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        HPDarkSky.shared.secret = TestSecret.secret!
        HPDarkSky.shared.requestWeather(forLocation: location) { (forecast, error) in
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
            XCTAssertEqual(forecast.location, location)
            XCTAssertNil(error)
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
        HPDarkSky.shared.requestWeather(forLocation: location, date: date) { (forecast, error) in
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
            XCTAssertEqual(forecast.location, location)
            XCTAssertEqual(forecast.currently?.time, date.removingMillisecondsFraction(), "Time was decoded incorrectly")
            XCTAssertNil(error)
            HPDarkSky.shared.secret = nil
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testSecretNotSet() {
        let exp = expectation(description: "fetched current data from server")

        HPDarkSky.shared.requestWeather(forLocation: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)) { response, error in
            exp.fulfill()
            XCTAssertNil(response)
            
            do {
                let err: NSError = try XCTUnwrap(error) as NSError
                XCTAssert(err == NSError.missingSecret)
            } catch let unwrapError {
                XCTFail(unwrapError.localizedDescription)
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
    public func removingMillisecondsFraction() -> Date {
        return Date(timeIntervalSince1970: timeIntervalSince1970.rounded(.towardZero))
    }
}
