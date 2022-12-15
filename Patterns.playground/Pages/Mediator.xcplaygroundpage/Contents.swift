import UIKit

enum Event: CustomStringConvertible {
    case addedToFavorites(prdouct: Product)
    case removedFromFavorites(prdouct: Product)
    
    var description: String {
        switch self {
        case .addedToFavorites(prdouct: _): return "added To Favorites"
        case .removedFromFavorites(prdouct: _): return "removed From Favorites"
        }
    }
}

struct Product: Equatable {
    let name: String
    var likesCount = 0
}

protocol ScreenUpdatable {
    func addToFavorites(product: Product)
    func removeFromFavorites(product: Product)
}

protocol Mediator: AnyObject {
    func notify(event: Event)
}

class ScreenMediator: Mediator {
    
    private var screens: [ScreenUpdatable]?
    
    func notify(event: Event) {
        print("ScreenMediator did recieve event: \(event)\n")
        
        switch event {
        case let .addedToFavorites(prdouct):
            screens?.forEach { $0.addToFavorites(product: prdouct) }
            
        case let .removedFromFavorites(prdouct):
            screens?.forEach { $0.removeFromFavorites(product: prdouct) }
        }
    }
    
    func update(screens: [ScreenUpdatable]) {
        self.screens = screens
    }
    
}

class ProductsViewController: ScreenUpdatable {
    
    private weak var mediator: Mediator?
    
    init(mediator: Mediator?) {
        self.mediator = mediator
    }
    
    func addToFavorites(product: Product) {
        print("ProductsViewController did increment likes count for \(product)")
    }
    
    func removeFromFavorites(product: Product) {
        print("ProductsViewController did decrement likes count for \(product)")
    }
    
    func simulate(event: Event) {
        print("ProductsViewController did recieve event: \(event)")
        mediator?.notify(event: event)
    }
}

class ProductDetailsViewController: ScreenUpdatable {
    
    private weak var mediator: Mediator?
    
    init(mediator: Mediator?) {
        self.mediator = mediator
    }
    
    func addToFavorites(product: Product) {
        print("ProductDetailsViewController did increment likes count for \(product)")
    }
    
    func removeFromFavorites(product: Product) {
        print("ProductDetailsViewController did decrement likes count for \(product)")
    }
    
    func simulate(event: Event) {
        print("ProductDetailsViewController did recieve event: \(event)")
        mediator?.notify(event: event)
    }
}

class ProfileViewController: ScreenUpdatable {
    
    private weak var mediator: Mediator?
    
    init(mediator: Mediator?) {
        self.mediator = mediator
    }
    
    func addToFavorites(product: Product) {
        print("ProfileViewController did add \(product) to Favorites")
    }
    
    func removeFromFavorites(product: Product) {
        print("ProfileViewController did remove \(product) from Favorites")
    }
    
    func simulate(event: Event) {
        print("ProfileViewController did recieve event: \(event)")
        mediator?.notify(event: event)
    }
}


let products = [Product(name: "Apple iPhone"),
                Product(name: "Apple Mac"),
                Product(name: "Apple Macbook"),
                Product(name: "Apple Watch"),
                Product(name: "Apple Airpods")]

let mediator = ScreenMediator()

let productsViewController = ProductsViewController(mediator: mediator)
let productDetailsViewController = ProductDetailsViewController(mediator: mediator)
let profileViewController = ProfileViewController(mediator: mediator)

mediator.update(screens: [productsViewController, productDetailsViewController, profileViewController])

productsViewController.simulate(event: .addedToFavorites(prdouct: products[1]))
print("\n------------\n")

productDetailsViewController.simulate(event: .removedFromFavorites(prdouct: products[1]))

// prints

// ProductsViewController did recieve event: added To Favorites
// ScreenMediator did recieve event: added To Favorites

// ProductsViewController did increment likes count for Product(name: "Apple Mac", likesCount: 0)
// ProductDetailsViewController did increment likes count for Product(name: "Apple Mac", likesCount: 0)
// ProfileViewController did add Product(name: "Apple Mac", likesCount: 0) to Favorites

// ----------

// ProductDetailsViewController did recieve event: removed From Favorites
// ScreenMediator did recieve event: removed From Favorites

// ProductsViewController did decrement likes count for Product(name: "Apple Mac", likesCount: 0)
// ProductDetailsViewController did decrement likes count for Product(name: "Apple Mac", likesCount: 0)
// ProfileViewController did remove Product(name: "Apple Mac", likesCount: 0) from Favorites

