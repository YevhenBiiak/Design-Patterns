import UIKit

// target
protocol AuthService {
    func startAuthorization(with viewController: UIViewController)
}

class Coordinator {
    
    private var topViewController: UIViewController {
        UIViewController()
    }

    func startAuthorization(with service: AuthService) {
        print("Coordinator starts authorization")
        
        service.startAuthorization(with: topViewController)
    }
}

class FacebookAuthSDK {
    
    func startAuthorization(with viewController: UIViewController) {
        print("Facebook WebView has been shown.")
    }
}

class TwitterAuthSDK {
    
    func presentAuthFlow(from viewController: UIViewController) {
        print("Twitter WebView has been shown.")
    }
}

// first way (extension)
extension FacebookAuthSDK: AuthService {}

extension TwitterAuthSDK: AuthService {
    
    func startAuthorization(with viewController: UIViewController) {
        presentAuthFlow(from: viewController)
    }
}

// second way (adaptor class)
class TwitterAuthAdaptor: AuthService {
    private let twitterAuthSDK: TwitterAuthSDK
    
    init(twitterAuthSDK: TwitterAuthSDK) {
        self.twitterAuthSDK = twitterAuthSDK
    }
    
    func startAuthorization(with viewController: UIViewController) {
        twitterAuthSDK.presentAuthFlow(from: viewController)
    }
}

let coordinator = Coordinator()

coordinator.startAuthorization(with: FacebookAuthSDK())

print()

// first way
coordinator.startAuthorization(with: TwitterAuthSDK())

print()

// second way
let twitterAuth = TwitterAuthAdaptor(twitterAuthSDK: TwitterAuthSDK())
coordinator.startAuthorization(with: twitterAuth)

// prints

// Coordinator starts authorization
// Twitter WebView has been shown.

// Coordinator starts authorization
// Facebook WebView has been shown.

// Coordinator starts authorization
// Facebook WebView has been shown.
