import UIKit

enum AuthType {
    case login
    case signUp
}

protocol AuthControllerFactory {
    static func authController(for type: AuthType) -> AuthViewController
}

class StudentAuthControllerFactory: AuthControllerFactory {
    
    static func authController(for type: AuthType) -> AuthViewController {
        var authView: AuthView
        
        print("Student View has been created")
        switch type {
        case .login: authView = StudentLoginView()
        case .signUp: authView = StudentSignUpView() }
        
        print("Student View Controller has been created")
        return StudentAuthViewController(contentView: authView)
    }
}

class TeacherAuthControllerFactory: AuthControllerFactory {
    
    static func authController(for type: AuthType) -> AuthViewController {
        var authView: AuthView
        
        print("Teacher View has been created")
        switch type {
        case .login: authView = TeacherLoginView()
        case .signUp: authView = TeacherSignUpView() }
        
        print("Teacher View Controller has been created")
        return TeacherAuthViewController(contentView: authView)
    }
}

// ---------

protocol AuthView {
    var contentView: UIView { get }
    var authHandler: (() -> Void)? { get set }
}

class StudentLoginView: UIView, AuthView {
    
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        
        button.addAction( UIAction { [weak self] _ in
            self?.authHandler?()
        }, for: .touchUpInside)
        
        return button
    }()
    
    var contentView: UIView { return self }
    
    var authHandler: (() -> Void)?
}

class StudentSignUpView: UIView, AuthView {
    
    class StudentSignUpContentView: UIView {
        
    }
    
    var contentView: UIView = StudentSignUpContentView()
    
    var authHandler: (() -> Void)?
}

class TeacherLoginView: UIView, AuthView {
    
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let forgotPasswordButton = UIButton()
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        
        button.addAction( UIAction { [weak self] _ in
            self?.authHandler?()
        }, for: .touchUpInside)
        
        return button
    }()
    
    var contentView: UIView { return self }
    
    var authHandler: (() -> Void)?
}

class TeacherSignUpView: UIView, AuthView {
    
    class TeacherSignUpContentView: UIView {
        
    }
    
    var contentView: UIView = TeacherSignUpContentView()
    
    var authHandler: (() -> Void)?
}

// ---------

class AuthViewController: UIViewController {
    
    private var contentView: AuthView
    
    init(contentView: AuthView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class StudentAuthViewController: AuthViewController {}
class TeacherAuthViewController: AuthViewController {}

class Router {

    private var navigationController = UINavigationController()
    private let factoryType: AuthControllerFactory.Type

    init(factoryType: AuthControllerFactory.Type) {
        self.factoryType = factoryType
    }

    func presentLogin() {
        let controller = factoryType.authController(for: .login)
        
        navigationController.pushViewController(controller, animated: true)
        
        print("Login screen has been presented\n")
    }

    func presentSignUp() {
        let controller = factoryType.authController(for: .signUp)
        
        navigationController.pushViewController(controller, animated: true)
        
        print("Sign up screen has been presented\n")
    }
}

var router = Router(factoryType: StudentAuthControllerFactory.self)
router.presentLogin()
router.presentSignUp()

router = Router(factoryType: TeacherAuthControllerFactory.self)
router.presentLogin()
router.presentSignUp()

// prints

// Student View has been created
// Student View Controller has been created
// Login screen has been presented

// Student View has been created
// Student View Controller has been created
// Sign up screen has been presented

// Teacher View has been created
// Teacher View Controller has been created
// Login screen has been presented

// Teacher View has been created
// Teacher View Controller has been created
// Sign up screen has been presented

