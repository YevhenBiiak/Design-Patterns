import Foundation

protocol Command {
    func execute()
}

struct SaveCommad: Command {
    
    private let editor: Editor
    
    init(editor: Editor) {
        self.editor = editor
    }
    
    func execute() {
        print("Saving: \(editor.state)")
    }
}

struct Button {
    
    private var command: Command?
    
    mutating func setCommand(_ command: Command) {
        self.command = command
    }
    
    func performAction() {
        command?.execute()
    }
}

struct Shortcut {
    
    private var command: Command?
    
    mutating func setCommand(_ command: Command) {
        self.command = command
    }
    
    func performAction() {
        command?.execute()
    }
}

class Editor {
    
    var state: String = "initial state"
    
    private var saveButton: Button
    private var saveShortcut: Shortcut
    
    init() {
        saveButton = Button()
        saveShortcut = Shortcut()
        
        defer {
            saveButton.setCommand(SaveCommad(editor: self))
            saveShortcut.setCommand(SaveCommad(editor: self))
        }
    }
    
    func simulateSaveButtonTap() {
        saveButton.performAction()
    }
    
    func simulateSaveShortcut() {
        saveShortcut.performAction()
    }
}

let editor = Editor()
editor.simulateSaveButtonTap()

editor.state = "modified"
editor.simulateSaveShortcut()

// prints

// Saving: initial state
// Saving: modified

print("\n")

protocol TransactionCommand: CustomStringConvertible {
    var isCompleted: Bool { get set }
    func execute()
}

class Account {
    
    var name: String
    var balance: Int
    
    init(name: String, balanca: Int) {
        self.name = name
        self.balance = balanca
    }
}

class Deposit: TransactionCommand {
    
    var isCompleted: Bool = false
    
    private var account: Account
    private var amount: Int
    
    init(account: Account, amount: Int) {
        self.account = account
        self.amount = amount
    }
    
    func execute() {
        account.balance += amount
        isCompleted = true
    }
    
    var description: String {
        "Account name: \(account.name). Operation: deposit \(amount)"
    }
}

class Withdraw: TransactionCommand {
    
    var isCompleted: Bool = false
    
    private var account: Account
    private var amount: Int
    
    init(account: Account, amount: Int) {
        self.account = account
        self.amount = amount
    }
    
    func execute() {
        if account.balance >= amount {
            account.balance -= amount
            isCompleted = true
        } else {
            print("No enough maney")
        }
    }
    
    var description: String {
        "Account name: \(account.name). Operation: withdraw \(amount)"
    }
}

class TransactionManager {
    
    static let shared = TransactionManager()
    
    private init() {}
    
    private var transactions: [TransactionCommand] = []
    
    var pendingTransactions: [TransactionCommand] {
        print("pending transactions:", transactions.filter { $0.isCompleted == false })
        
        return transactions.filter { $0.isCompleted == false }
    }
    
    func addTransaction(_ transaction: TransactionCommand) {
        transactions.append(transaction)
    }
    
    func processTransactions() {
        for transaction in transactions where transaction.isCompleted == false {
            transaction.execute()
        }
    }
}

let account = Account(name: "John", balanca: 0)

TransactionManager.shared.addTransaction(Deposit(account: account, amount: 100))
TransactionManager.shared.pendingTransactions

TransactionManager.shared.processTransactions()
TransactionManager.shared.pendingTransactions

TransactionManager.shared.addTransaction(Withdraw(account: account, amount: 99))
TransactionManager.shared.pendingTransactions

// prints

// pending transactions: [Account name: John. Operation: deposit 100]
// pending transactions: []
// pending transactions: [Account name: John. Operation: withdraw 99]

