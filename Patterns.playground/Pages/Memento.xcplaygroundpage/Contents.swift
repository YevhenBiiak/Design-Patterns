import UIKit

class View {
    
    private struct Snapshot: Memento {
        let frame: CGRect
    }
    
    private var frame: CGRect = .zero
    
    init(frame: CGRect) {
        self.frame = frame
    }
    
    func move(at point: CGPoint) {
        frame.origin = point
    }
    
    func resize(to size: CGSize) {
        frame.size = size
    }
    
    func description() -> String {
        return "current position: \(frame)"
    }
    
    func save() -> Memento {
        return Snapshot(frame: frame)
    }
    
    func restore(from snapshot: Memento) {
        guard let state = snapshot as? Snapshot else { return }
        frame = state.frame
    }
}

protocol Memento { }

struct Stack<T> {
    var stack: [T] = []
    mutating func clear()            { stack = [] }
    mutating func pop() -> T?        { stack.last }
    mutating func push(_ element: T) { stack.append(element) }
}

class Caretaker {
    
    private var undoStack = Stack<Memento>()
    private var redoStack = Stack<Memento>()
    private var currentMemento: Memento
    
    private var originator: View

    init(originator: View) {
        self.originator = originator
        self.currentMemento = originator.save()
    }
    
    func save() {
        redoStack.clear()
        undoStack.push(currentMemento)
        currentMemento = originator.save()
        print("Save. \(originator.description())")
    }
    
    func undo() {
        guard let memento = undoStack.pop() else { return }
        
        redoStack.push(currentMemento)
        currentMemento = memento
        originator.restore(from: currentMemento)
        print("Undo. \(originator.description())")
    }
    
    func redo() {
        guard let memento = redoStack.pop() else { return }
        
        undoStack.push(currentMemento)
        currentMemento = memento
        originator.restore(from: currentMemento)
        print("Redo. \(originator.description())")
    }
}

let view = View(frame: CGRect(x: 0, y: 0, width: 5, height: 10))
let caretaker = Caretaker(originator: view)

caretaker.save()
view.move(at: CGPoint(x: 5, y: 5))

caretaker.save()
view.resize(to: CGSize(width: 10, height: 20))

caretaker.undo()
caretaker.redo()

// prints

// Save. current position: (0.0, 0.0, 5.0, 10.0)
// Save. current position: (5.0, 5.0, 5.0, 10.0)
// Undo. current position: (0.0, 0.0, 5.0, 10.0)
// Redo. current position: (5.0, 5.0, 5.0, 10.0)
