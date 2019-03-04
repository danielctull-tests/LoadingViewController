
import Foundation

public struct Resource<Value> {
    public let request: URLRequest
    public let transform: (Data) throws -> Value

	public init(request: URLRequest, transform: @escaping (Data) throws -> Value) {
		self.request = request
		self.transform = transform
	}
}
