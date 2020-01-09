import Foundation

internal struct APIError: Codable, Equatable {
    let code: Int
    let error: String

    internal func makeNSError() -> NSError {
        return NSError(description: error, code: code)
    }
}
