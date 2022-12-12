import Foundation

class OneTimePassword {
    
    func genOTP() -> String {
        let randomOTP = Int.random(in: 1000...9999)
        return randomOTP.description
    }
    
    func saveOTP(otp: String) {
        fatalError("This method must be overriden")
    }
    
    func getMessage(forOTP otp: String) -> String {
        fatalError("This method must be overriden")
    }
    
    func sendNotification(message: String) throws {
        fatalError("This method must be overriden")
    }
    
    final func genAndSendOTP() throws {
        
        let otp = genOTP()
        let message = getMessage(forOTP: otp)
        
        saveOTP(otp: otp)
        
        try sendNotification(message: message)
    }
}

class Sms: OneTimePassword {
    
    override func genOTP() -> String {
        let randomOTP = super.genOTP()
        print("SMS: generating random otp \(randomOTP)")
        return randomOTP.description
    }
    
    override func saveOTP(otp: String) {
        print("SMS: saving otp: \(otp) to cache")
    }
    
    override func getMessage(forOTP otp: String) -> String {
        return "SMS OTP for login is " + otp
    }
    
    override func sendNotification(message: String) throws {
        print("SMS: sending sms: \(message)\n")
    }
}

class Email: OneTimePassword {
    
    override func genOTP() -> String {
        let randomOTP = super.genOTP()
        print("EMAIL: generating random otp \(randomOTP)")
        return randomOTP.description
    }
    
    override func saveOTP(otp: String) {
        print("EMAIL: saving otp: \(otp) to cache")
    }
    
    override func getMessage(forOTP otp: String) -> String {
        return "EMAIL OTP for login is " + otp
    }
    
    override func sendNotification(message: String) throws {
        print("EMAIL: sending email: \(message)\n")
    }
}

let sms = Sms()

try! sms.genAndSendOTP()

let emal = Email()

try! emal.genAndSendOTP()

// prints

// SMS: generating random otp 6102
// SMS: saving otp: 6102 to cache
// SMS: sending sms: SMS OTP for login is 6102

// EMAIL: generating random otp 2661
// EMAIL: saving otp: 2661 to cache
// EMAIL: sending email: EMAIL OTP for login is 2661
