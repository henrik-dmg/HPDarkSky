import XCTest
import CoreLocation
@testable import HPDarkSky

final class HPDarkSkyTests: XCTestCase {
    
    func makeRequestObject() -> DarkSkyRequest {
        return DarkSkyRequest(
            secret: TestSecret.secret,
            location: CLLocationCoordinate2D(latitude: 50.12312, longitude: -12.12912),
            excludedFields: ExcludableFields.allCases)
    }
    
    func testExcludingCurrently() {
        let request = makeRequestObject()
        let exp = expectation(description: "fetched empty forecast from server")
        
        HPDarkSky.shared.performRequest(request) { (forecast, error) in
            XCTAssertNil(forecast?.currently)
            XCTAssertNil(error)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testBasicRequest() {
        var request = makeRequestObject()
        request.excludedFields = ExcludableFields.allCases.filter({$0 != .currently})
        let exp = expectation(description: "fetched current data from server")

        HPDarkSky.shared.performRequest(request) { (forecast, error) in
            XCTAssertNotNil(forecast?.currently)
            XCTAssertNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }
    
    static var allTests = [
        "testBasicRequest": testBasicRequest,
        "testExcludingCurrently": testExcludingCurrently
    ]
}
