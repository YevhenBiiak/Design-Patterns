import Foundation

extension String: Error {}

struct Account {
    
    var name: String

    init(name: String) {
        self.name = name
    }

    func checkAccount(accountName: String) throws {
        if self.name != accountName {
            throw "Account Name is incorrect"
        }
        print("Account Verified")
    }
}

struct Wallet {
    
    var balance: Int = 0
    
    mutating func creditBalance(amount: Int) {
        self.balance += amount
    }
    
    mutating func debitBalance(amount: Int) throws {
        if self.balance < amount {
            throw "Balance is not sufficient"
        }
        
        print("Wallet balance is Sufficient")
        self.balance -= amount
    }
}

struct SecurityCode {
    
    var code: Int
    
    init(code: Int) {
        self.code = code
    }
    
    func checkCode(incomingCode: Int) throws {
        if self.code != incomingCode {
            throw "Security Code is incorrect"
        }
        print("SecurityCode Verified")
    }
}

struct Ledger {
    
    func makeEntry(accountId: String, txnType: String, amount: Int) {
        
        print("Make ledger entry for accountId \(accountId) with txnType \(txnType) for amount \(amount)")
    }
}

struct Notification {
    
    func sendWalletCreditNotification() {
        
        print("Sending wallet credit notification")
    }

    func sendWalletDebitNotification() {
        
        print("Sending wallet debit notification")
    }
}

class WalletFacade {

    private var account: Account
    private var wallet: Wallet
    private var securityCode: SecurityCode
    private var notification: Notification
    private var ledger: Ledger
    
    init(accountId: String, code: Int) {
        print("\nStarting create account")
        
        self.account = Account(name: accountId)
        self.wallet = Wallet()
        self.securityCode = SecurityCode(code: code)
        self.notification = Notification()
        self.ledger = Ledger()
        
        print("Account created")
    }

    func addMoneyToWallet(accountId: String, securityCode: Int, amount: Int) throws {
        print("\nStarting add money to wallet")
        
        try self.account.checkAccount(accountName: accountId)
        try self.securityCode.checkCode(incomingCode: securityCode)
        
        self.wallet.creditBalance(amount: amount)
        self.notification.sendWalletCreditNotification()
        self.ledger.makeEntry(accountId: accountId, txnType: "credit", amount: amount)
    }

    func deductMoneyFromWallet(accountId: String, securityCode: Int, amount: Int) throws {
        print("\nStarting debit money from wallet")
        
        try self.account.checkAccount(accountName: accountId)
        try self.securityCode.checkCode(incomingCode: securityCode)
        try self.wallet.debitBalance(amount: amount)
        
        self.notification.sendWalletDebitNotification()
        self.ledger.makeEntry(accountId: accountId, txnType: "debit", amount: amount)
    }
}

let walletFacade = WalletFacade(accountId: "abc", code: 1234)

do  {
    
    try walletFacade.addMoneyToWallet(accountId: "abc", securityCode: 1234, amount: 10)
    
    try walletFacade.deductMoneyFromWallet(accountId: "abc", securityCode: 1234, amount: 5)
    
    try walletFacade.deductMoneyFromWallet(accountId: "abc", securityCode: 1234, amount: 6)
    
} catch {
    print("-- ERROR:", error)
}

// prints

// Starting create account
// Account created

// Starting add money to wallet
// Account Verified
// SecurityCode Verified
// Sending wallet credit notification
// Make ledger entry for accountId abc with txnType credit for amount 10

// Starting debit money from wallet
// Account Verified
// SecurityCode Verified
// Wallet balance is Sufficient
// Sending wallet debit notification
// Make ledger entry for accountId abc with txnType debit for amount 5

// Starting debit money from wallet
// Account Verified
// SecurityCode Verified
// -- ERROR: Balance is not sufficient
