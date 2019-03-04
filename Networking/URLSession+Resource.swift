
import Foundation

extension URLSession {

    public func load<Value>(_ resource: Resource<Value>, completion: @escaping (Result<Value, Error>) -> Void) {

        perform(resource.request) { result in
            let newResult = result.catchMap(resource.transform)
            completion(newResult)
        }
    }

    private func perform(_ request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {

        let task = dataTask(with: request) { data, response, underlyingError in

            guard let data = data else {
                let error = NetworkError(response: response, underlyingError: underlyingError)
                completion(.failure(error))
                return
            }

            completion(.success(data))
        }

        task.resume()
    }
}
