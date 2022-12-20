import UIKit

class SplashViewController: UIViewController {}
class LoginViewController: UIViewController {}
class AddProductViewController: UIViewController {}

protocol Coordinator {
    var presentingViewController: UIViewController { get set }
    init(presentingViewController: UIViewController)
    func start()
    func makeViewController() -> UIViewController
}

extension Coordinator {
    
    func start() {
        presentingViewController.present(makeViewController(), animated: true)
        print("Start coordinator\n")
    }
}

class LoginCoordinator: Coordinator {
    
    var presentingViewController: UIViewController
    
    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func makeViewController() -> UIViewController {
        print("Create LoginViewController")
        return LoginViewController()
    }
}

class AddProductCoordinator: Coordinator {
    
    var presentingViewController: UIViewController
    
    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func makeViewController() -> UIViewController {
        print("Create AddProductViewController")
        return AddProductViewController()
    }
}

let splashViewController = SplashViewController()
let loginCoordinator = LoginCoordinator(presentingViewController: splashViewController)
let addProductCoordinator = AddProductCoordinator(presentingViewController: splashViewController)

loginCoordinator.start()

addProductCoordinator.start()

// ptints

// Create LoginViewController
// Start coordinator

// Create AddProductViewController
// Start coordinator
