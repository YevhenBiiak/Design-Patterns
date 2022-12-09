import Foundation

class Object {
    // private property
    private var configuration: Int
    
    init() {
        // hard work of initialization
        let random = Int.random(in: 1...10)
        (1...random).forEach { _ in sleep(1) }
        configuration = random
    }
    
    init(configuration: Int) {
        self.configuration = configuration
    }
}

// own implementation

protocol Prototype {
    func clone() -> Prototype
}

extension Object: Prototype {
    func clone() -> Prototype {
        return Object(configuration: self.configuration)
    }
}

// using Foundation
extension Object: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return Object(configuration: self.configuration)
    }
}

let object = Object()
let clone = object.clone() as! Object
let copy = object.copy() as! Object

print(ObjectIdentifier(object))  // ObjectIdentifier(0x000060000259c0e0)
print(ObjectIdentifier(clone))   // ObjectIdentifier(0x00006000025b4160)
print(ObjectIdentifier(copy))    // ObjectIdentifier(0x00006000025b41c0)


// MARK: - Another Example -

class ComplicatedObject {
    private var configuration: Data
    
    init(url: URL) {
        let manager = WebManager()
        configuration = manager.getData(with: url)
    }
    
    private init(object: ComplicatedObject) {
        self.configuration = object.configuration
    }
    
    func clone() -> ComplicatedObject {
        ComplicatedObject(object: self)
    }
}

class WebManager {
    func getData(with url: URL) -> Data {
        return Data()
    }
}

let cObject = ComplicatedObject(url: URL(string: "https://site.com/config")!)
let cClone = cObject.clone()

print(ObjectIdentifier(cObject))  // ObjectIdentifier(0x0000600003ee4560)
print(ObjectIdentifier(cClone))   // ObjectIdentifier(0x0000600003eb63e0)

