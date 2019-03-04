
extension Result {

    public func catchMap<NewSuccess>(
        _ transform: (Success) throws -> NewSuccess
    ) -> Result<NewSuccess, Error> {

        switch self {

        case let .success(success):
            do {
                return .success(try transform(success))
            } catch {
                return .failure(error)
            }

        case let .failure(failure):
            return .failure(failure)
        }
    }
}
