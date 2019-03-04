
import Networking
import UIKit

final public class LoadingViewController<Success>: UIViewController {

	let session: URLSession
	let resource: Resource<Success>
	let loadingViewController: UIViewController
	let successViewController: (Success) -> UIViewController
	let failureViewController: (Error) -> UIViewController

	public init(
		session: URLSession = URLSession.shared,
		resource: Resource<Success>,
		loadingViewController: UIViewController,
		successViewController: @escaping (Success) -> UIViewController,
		failureViewController: @escaping (Error) -> UIViewController
	) {
		self.session = session
		self.resource = resource
		self.loadingViewController = loadingViewController
		self.successViewController = successViewController
		self.failureViewController = failureViewController
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override public func viewDidLoad() {
		super.viewDidLoad()
		transition(to: loadingViewController, animated: false)
	}

	override public func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		let failureViewController = self.failureViewController
		let successViewController = self.successViewController

		session.load(resource) { [weak self] result in
			DispatchQueue.main.async {
				switch result {
				case .failure(let failure):
					self?.transition(to: failureViewController(failure), animated: true)
				case .success(let success):
					self?.transition(to: successViewController(success), animated: true)
				}
			}
		}
	}

	private func transition(to child: UIViewController, animated: Bool) {

		let oldChildren = children

		child.view.alpha = 0
		child.view.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(child.view)
		child.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		child.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		child.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

		let duration: TimeInterval = animated ? 1/3 : 0
		UIView.animate(withDuration: duration, animations: {

			child.view.alpha = 1

		}, completion: { _ in

			oldChildren.forEach { old in
				old.willMove(toParent: nil)
				old.view.removeFromSuperview()
				old.removeFromParent()
			}
		})
	}
}
