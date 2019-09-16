import XCTest
import CoreLocation
@testable import HPDarkSky

#if canImport(Combine)
// TODO
#endif

@available(iOS 13, *)
final class IconTests: XCTestCase {
    func testHollowIcon() {
        WeatherIcon.allCases.forEach { icon in
            let hollow = icon.hollowIcon(compatibleWith: nil)
            let filled = icon.filledIcon(compatibleWith: nil)
            XCTAssertNotNil(hollow)
            XCTAssertNotNil(filled)
        }
    }
    
    static var allTests = [
        ("testHollowIcon", testHollowIcon)
    ]
}
