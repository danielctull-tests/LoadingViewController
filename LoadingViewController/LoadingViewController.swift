
import Networking
import UIKit

final class LoadingViewController<Success>: UIViewController {

    public var session = URLSession.shared { didSet { loadResource() }}
    public var resource: Resource<Success>? { didSet { loadResource() }}

    private var result: Result<Success, Error>? { didSet { updateResult() }}

    private func loadResource() {

        guard let resource = resource else { return }

        session.load(resource) { [weak self] result in
            self?.result = result
        }
    }

    private func updateResult() {

        guard let result = result else {
            // Show loading view controller
            return
        }

        switch result {

        case .failure(let failure):
            // Show failure view controller
            print(failure)

        case .success(let success):
            // Show failure view controller
            print(success)
        }
    }

    public var loadingViewController = UIViewController() { didSet { updateResult() }}





    public func setSuccessViewController<SuccessViewController>(_ successViewController: SuccessViewController)
        where SuccessViewController: UIViewController,
        SuccessViewController: SuccessContainer,
        SuccessViewController.Success == Success {

    }

    public func setFailureViewController<FailureViewController>(_ failureViewController: FailureViewController)
        where FailureViewController: UIViewController,
        FailureViewController: FailureContainer {

    }
}

public protocol FailureContainer {
    var failure: Error { get set }
}

public protocol SuccessContainer {
    associatedtype Success
    var success: Success { get set }
}
