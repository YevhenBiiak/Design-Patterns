import Foundation

protocol State {
    var description: String { get }
        
    func on(printer: Printer)
    func off(printer: Printer)
    func print(printer: Printer)
}

class OnState: State {
    
    var description: String { "Printer in On State \(Date())" }
    
    func on(printer: Printer)    {
        Swift.print("Printer is On already")
    }
    func off(printer: Printer)   {
        Swift.print("Printer is turning Off")
        printer.setState(OffState())
    }
    func print(printer: Printer) {
        Swift.print("Printer is printing")
        printer.setState(PrintState())
    }
}

class OffState: State {
    
    var description: String { "Printer in Off State \(Date())" }
    
    func on(printer: Printer)    {
        Swift.print("Printer is turning On")
        printer.setState(OnState())
    }
    func off(printer: Printer)   {
        Swift.print("Printer is Off already")
    }
    func print(printer: Printer) {
        Swift.print("Printer is Off now")
    }
}

class PrintState: State {
    
    var description: String { "Printer in Print State \(Date())" }
    
    func on(printer: Printer)    {
        Swift.print("Printer is On already")
    }
    func off(printer: Printer)   {
        Swift.print("Printer is turning Off")
        printer.setState(OffState())
    }
    func print(printer: Printer) {
        Swift.print("Printer is printing already")
    }
}

class Printer {
    
    var history = "\nState history:\n"
    
    private var state: State
    
    init() {
        state = OffState()
        history += state.description + "\n"
    }
    
    func setState(_ state: State) {
        self.state = state
        history += state.description + "\n"
    }
    
    func turnOn() {
        state.on(printer: self)
    }
    
    func turnOff() {
        state.off(printer: self)
    }
    
    func printDocument() {
        state.print(printer: self)
    }
}

let printer = Printer()
printer.turnOn()
printer.printDocument()
printer.turnOn()
printer.turnOff()
print(printer.history)

// prints

// Printer is turning On
// Printer is printing
// Printer is On already
// Printer is turning Off

// State history:
// Printer in Off State 2022-12-11 08:03:37 +0000
// Printer in On State 2022-12-11 08:03:37 +0000
// Printer in Print State 2022-12-11 08:03:37 +0000
// Printer in Off State 2022-12-11 08:03:37 +0000

