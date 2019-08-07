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
    
    func testURLBuilder() {
        let mockSecret = "141029jsaiosdas90fh0319oiaenv98eqbf3ofbhqoawihfoiaeh"
        HPDarkSky.shared.secret = mockSecret
        let url = HPDarkSky.shared.buildURL(for: mockSecret, location: CLLocationCoordinate2D(latitude: 10.0, longitude: -10.12512))
        let expectedURL = DarkSkyRequest.baseURL.absoluteString + "/\(mockSecret)/10.0,-10.12512"
        
        print(url.absoluteString)
        
        print(expectedURL)
        XCTAssert(url.absoluteString == expectedURL)
    }
    
    func testBasicRequest() {
        let request = DarkSkyRequest(location: CLLocationCoordinate2D(latitude: 50.12312, longitude: -12.12912))
        let exp = expectation(description: "fetched data from server")
        
        HPDarkSky.shared.performRequest(request) { (forecast, error) in
            exp.fulfill()
            XCTAssertNotNil(forecast)
            XCTAssertNil(error)
        }
        
        wait(for: [exp], timeout: 5)
    }
    
    static var allTests = [
        "testURLBuilder": testURLBuilder,
        "testBasicRequest": testBasicRequest
    ]
}
