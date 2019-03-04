
import Foundation

public struct Resource<Value> {
    public let request: URLRequest
    public let transform: (Data) throws -> Value
}
