import Foundation

class Singleton {
    
    static let shared: Singleton = Singleton()
    
    var value: Int = 0
    
    private init() {}
    
    func printValue() {
        print(value)
    }
}

let object1 = Singleton.shared
object1.value = 100

let object2 = Singleton.shared
object2.value = 500

object1.printValue()
object2.printValue()

print(object1 === object2)

// prints

// 500
// 500
// true
