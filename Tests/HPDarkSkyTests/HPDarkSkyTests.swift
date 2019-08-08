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
    
    func testExcludingCurrently() {
        let request = DarkSkyRequest(secret: HPDarkSky.shared.secret!, location: CLLocationCoordinate2D(latitude: 50.12312, longitude: -12.12912), excludedFields: ExcludableFields.allCases)
        let exp = expectation(description: "fetched data from server")
        
        HPDarkSky.shared.performRequest(request) { (forecast, error) in
            exp.fulfill()
            print(error?.localizedDescription)
            XCTAssertNotNil(forecast?.currently)
            XCTAssertNil(error)
        }
        
        wait(for: [exp], timeout: 5)
    }
    
    static var allTests = [
        "testBasicRequest": testExcludingCurrently
    ]
}
