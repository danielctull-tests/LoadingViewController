
import Loading
import Networking
import UIKit

final class ViewController: UIViewController {

	private func successViewController(for data: Data) -> UIViewController {
		return UIStoryboard(name: "Success", bundle: nil).instantiateInitialViewController()!
	}

	private func failureViewController(for error: Error) -> UIViewController {
		return UIStoryboard(name: "Failure", bundle: nil).instantiateInitialViewController()!
	}

	private let loadingViewController = UIStoryboard(name: "Loading", bundle: nil).instantiateInitialViewController()!

	@IBAction func showFailure(_ sender: Any) {

		let request = URLRequest(url: URL(string: "http://duckduckgo.com")!)
		let resource = Resource(request: request, transform: { data in return data })
		let loading = LoadingViewController(resource: resource,
											loadingViewController: loadingViewController,
											successViewController: successViewController(for:),
											failureViewController: failureViewController(for:))
		show(loading, sender: self)
	}

	@IBAction func showSuccess(_ sender: Any) {

		let request = URLRequest(url: URL(string: "https://duckduckgo.com")!)
		let resource = Resource(request: request, transform: { data in return data })
		let loading = LoadingViewController(resource: resource,
											loadingViewController: loadingViewController,
											successViewController: successViewController(for:),
											failureViewController: failureViewController(for:))
		show(loading, sender: self)
	}
}
