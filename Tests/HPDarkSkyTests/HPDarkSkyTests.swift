import XCTest
import CoreLocation
@testable import HPDarkSky

final class HPDarkSkyTests: XCTestCase {
    
    func testURLBuilder() {
        let mockSecret = "141029jsaiosdas90fh0319oiaenv98eqbf3ofbhqoawihfoiaeh"
        HPDarkSky.shared.secret = mockSecret
        let url = HPDarkSky.shared.buildURL(for: mockSecret, location: CLLocationCoordinate2D(latitude: 10.0, longitude: -10.12512))
        let expectedURL = DarkSkyRequest.baseURL.absoluteString + "/\(mockSecret)/10.0,-10.12512"
        
        print(url.absoluteString)
        
        print(expectedURL)
        XCTAssert(url.absoluteString == expectedURL)
    }
    
    static var allTests = ["testURLBuilder": testURLBuilder]
}
