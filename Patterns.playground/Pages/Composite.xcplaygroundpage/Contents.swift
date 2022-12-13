import UIKit

protocol Theme: CustomStringConvertible {}
protocol Themable {}

protocol ViewTheme: Theme {
    var backgroundColor: UIColor { get }
}

protocol LabelTheme: Theme {
    var labelTextColor: UIColor { get }
}

protocol ButtonTheme: Theme {
    var buttonTintColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
    var buttonHighlightedTitleColor: UIColor { get }
}

extension Themable where Self: UIViewController {
    func apply<T>(theme: T) where T : ViewTheme {
        
        self.view.apply(theme: theme)
        
        for view in view.subviews {
            view.apply(theme: theme)
        }
        
        print("\(description): has applied \(theme.description)")
    }
}

extension Themable where Self: UIView {
    func apply<T>(theme: T) where T : ViewTheme {
        
        self.backgroundColor = theme.backgroundColor
        
        print("\(description): has applied \(theme.description)")
    }
}

extension Themable where Self: UILabel {
    func apply<T>(theme: T) where T : LabelTheme {
        
        self.textColor = theme.labelTextColor
        
        print("\(description): has applied \(theme.description)")
    }
}

extension Themable where Self: UIButton {
    func apply<T>(theme: T) where T : ButtonTheme {
        
        self.tintColor = theme.buttonTintColor
        self.setTitleColor(theme.buttonTitleColor, for: .normal)
        self.setTitleColor(theme.buttonHighlightedTitleColor, for: .highlighted)
        
        print("\(description): has applied \(theme.description)")
    }
}

extension UIViewController: Themable {}
extension UIView: Themable {}

extension ViewController {
    override var description: String { return "ViewController" }
}

extension ViewController.RootView {
    override var description: String { return "RootView" }
}

extension UIButton {
    open override var description: String { return "UIButton" }
}

extension UILabel {
    open override var description: String { return "UILabel" }
}

// usage

struct LigthTheme: ViewTheme, LabelTheme, ButtonTheme {
    
    var backgroundColor: UIColor = .white
    
    var labelTextColor: UIColor = .black
    
    var buttonTintColor: UIColor = .systemBlue
    var buttonTitleColor: UIColor = .white
    var buttonHighlightedTitleColor: UIColor = .systemCyan
    
    var description: String { "Ligth Theme" }
}

struct DarkTheme: ViewTheme, LabelTheme, ButtonTheme {
    
    var backgroundColor: UIColor = .black
    
    var labelTextColor: UIColor = .white
    
    var buttonTintColor: UIColor = .white
    var buttonTitleColor: UIColor = .black
    var buttonHighlightedTitleColor: UIColor = .systemGray
    
    var description: String { "Dark Theme" }
}

class ViewController: UIViewController {
    
    class RootView: UIView {
        
        let label = UILabel()
        let button = UIButton()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            configureSelf()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configureSelf() {
            addSubview(label)
            addSubview(button)
        }
    }
    
    override func loadView() {
        view = RootView()
    }
}

let viewController = ViewController()

let darkTheme = DarkTheme()
viewController.apply(theme: darkTheme)

print()

let lightTheme = LigthTheme()
viewController.apply(theme: lightTheme)

// prints

// RootView: has applied Dark Theme
// UILabel: has applied Dark Theme
// UIButton: has applied Dark Theme
// ViewController: has applied Dark Theme

// RootView: has applied Ligth Theme
// UILabel: has applied Ligth Theme
// UIButton: has applied Ligth Theme
// ViewController: has applied Ligth Theme
