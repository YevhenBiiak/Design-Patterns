import Foundation

protocol Shape {
    var position: CGPoint { get set }
    func move(point: CGPoint)
    func draw()
}

class Circle: Shape {
    var position: CGPoint
    
    init(position: CGPoint = .init()) {
        self.position = position
    }
    
    func move(point: CGPoint) {}
    func draw() {}
}

class Rectangle: Shape {
    var position: CGPoint
    
    init(position: CGPoint = .init()) {
        self.position = position
    }
    
    func move(point: CGPoint) {}
    func draw() {}
}

// Imaplementation

protocol Visitable {
    func accept(visitor: Visitor)
}

extension Circle: Visitable {
    func accept(visitor: Visitor) {
        visitor.visit(circle: self)
    }
}

extension Rectangle: Visitable {
    func accept(visitor: Visitor) {
        visitor.visit(rectangle: self)
    }
}

protocol Visitor {
    func visit(circle: Circle)
    func visit(rectangle: Rectangle)
}

class XMLExporter: Visitor {
    func visit(circle: Circle) {
        print("A Circle at position \(circle.position) has been exported to XML")
    }
    func visit(rectangle: Rectangle) {
        print("A Rectangle at position \(rectangle.position) has been exported to XML")
    }
}

class HTMLExporter: Visitor {
    func visit(circle: Circle) {
        print("A Circle at position \(circle.position) has been exported to HTML")
    }
    func visit(rectangle: Rectangle) {
        print("A Rectangle at position \(rectangle.position) has been exported to HTML")
    }
}

let circle1 = Circle()
let circle2 = Circle(position: CGPoint(x: 1.1, y: 1.1))

let rectangle1 = Rectangle()
let rectangle2 = Rectangle(position: CGPoint(x: 2.2, y: 2.2))

let xmlExporter = XMLExporter()
let htmlExporter = HTMLExporter()

let array: [Visitable] = [circle1, circle2, rectangle1, rectangle2]

array.forEach { shape in
    shape.accept(visitor: xmlExporter)
}
array.forEach { shape in
    shape.accept(visitor: htmlExporter)
}

// prints

// A Circle at position (0.0, 0.0) has been exported to XML
// A Circle at position (1.1, 1.1) has been exported to XML
// A Rectangle at position (0.0, 0.0) has been exported to XML
// A Rectangle at position (2.2, 2.2) has been exported to XML

// A Circle at position (0.0, 0.0) has been exported to HTML
// A Circle at position (1.1, 1.1) has been exported to HTML
// A Rectangle at position (0.0, 0.0) has been exported to HTML
// A Rectangle at position (2.2, 2.2) has been exported to HTML
