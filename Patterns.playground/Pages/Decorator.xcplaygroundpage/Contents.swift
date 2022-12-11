import Foundation

protocol Notifier: CustomStringConvertible {
    func sendMessage(_ message: String)
}

class DefaultNotifier: Notifier {
    
    var description: String {
        return "The Notifier uses notifications such as: Facebook"
    }
    
    func sendMessage(_ message: String) {
        sendViaFacebook(message)
    }
    
    private func sendViaFacebook(_ message: String) {
        print("(Facebook) \(message)")
    }
}

class NotifierDecorator: Notifier {
    
    var description: String {
        notifier.description
    }
    
    private var notifier: Notifier
    
    required init(notifier: Notifier) {
        self.notifier = notifier
    }
    
    func sendMessage(_ message: String) {
        notifier.sendMessage(message)
    }
}

class SMSNotifier: NotifierDecorator {
    
    required init(notifier: Notifier) {
        super.init(notifier: notifier)
    }
    
    override func sendMessage(_ message: String) {
        super.sendMessage(message)
        
        sendViaSMS(message)
    }
    
    private func sendViaSMS(_ message: String) {
        print("(SMS) \(message)")
    }
}

class EmailNotifier: NotifierDecorator {
    
    required init(notifier: Notifier) {
        super.init(notifier: notifier)
    }
    
    override func sendMessage(_ message: String) {
        super.sendMessage(message)
        
        sendViaEmail(message)
    }
    
    private func sendViaEmail(_ message: String) {
        print("(Email) \(message)")
    }
}


var notifier: Notifier = DefaultNotifier()
notifier.sendMessage("Hello, world")
print()

notifier = SMSNotifier(notifier: notifier)
notifier.sendMessage("Hello, John")
print()

notifier = EmailNotifier(notifier: notifier)
notifier.sendMessage("Hi, how are you?")
print()

// prints

// (Facebook) Hello, world

// (Facebook) Hello, John
// (SMS) Hello, John

// (Facebook) Hi, how are you?
// (SMS) Hi, how are you?
// (Email) Hi, how are you?

