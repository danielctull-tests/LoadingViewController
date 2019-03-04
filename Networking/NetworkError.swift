
import Foundation

public struct NetworkError: Error {
    public let response: URLResponse?
    public let underlyingError: Swift.Error?
}
