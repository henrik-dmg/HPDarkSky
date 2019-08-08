import XCTest
import CoreLocation
@testable import HPDarkSky

final class HPDarkSkyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        HPDarkSky.shared.secret = "296a22af3e54045f710c0555cd081857"
    }
    
    override func tearDown() {
        super.tearDown()
        
        HPDarkSky.shared.secret = nil
    }
    
    func makeRequestObject() -> DarkSkyRequest {
        return DarkSkyRequest(secret: HPDarkSky.shared.secret!, location: CLLocationCoordinate2D(latitude: 50.12312, longitude: -12.12912), excludedFields: ExcludableFields.allCases)
    }
    
    func testExcludingCurrently() {
        let request = makeRequestObject()
        let exp = expectation(description: "fetched data from server")
        
        HPDarkSky.shared.performRequest(request) { (forecast, error) in
            exp.fulfill()
            XCTAssertNil(forecast?.currently)
            XCTAssertNil(error)
        }
        
        wait(for: [exp], timeout: 10)
    }
    
    func testBasicRequest() {
        var request = makeRequestObject()
        request.excludedFields = ExcludableFields.allCases.filter({$0 != .currently})
        let exp = expectation(description: "fetched data from server")
        
        HPDarkSky.shared.performRequest(request) { (forecast, error) in
            exp.fulfill()
            XCTAssertNotNil(forecast?.currently)
            XCTAssertNil(error)
        }
        
        wait(for: [exp], timeout: 10)
    }
    
    static var allTests = [
        "testBasicRequest": testBasicRequest,
        "testExcludingCurrently": testExcludingCurrently
    ]
}
