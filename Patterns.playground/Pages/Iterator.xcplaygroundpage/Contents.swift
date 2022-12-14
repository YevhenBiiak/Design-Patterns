import Foundation

class Tree<T> {
    
    var value: T
    var left: Tree<T>?
    var right: Tree<T>?
    
    init(value: T) {
        self.value = value
    }
    
    func makeIterator() -> AnyIterator<T> {
        
        return AnyIterator(parse().makeIterator())
    }
    
    func parse() -> [T] {
        
        return [value] + (left?.parse() ?? []) + (right?.parse() ?? [])
    }
}

let tree = Tree(value: "one")

tree.left = Tree(value: "two")
tree.right = Tree(value: "three")

tree.left?.left = Tree(value: "four")
tree.left?.right = Tree(value: "five")

tree.right?.left = Tree(value: "six")
tree.right?.right = Tree(value: "seven")

let iterator = tree.makeIterator()

while case let value? = iterator.next() {
    print(value)
}

// prints

// one
// two
// four
// five
// three
// six
// seven
