import XCTest
@testable import HPDarkSky

final class HPDarkSkyTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(HPDarkSky().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
