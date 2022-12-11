import Foundation

protocol DataModel {
    var id: String { get set }
}

protocol DataStorage {
    func loadModels<T: DataModel>() -> [T]
}

struct User: DataModel {
    
    var id: String = UUID().uuidString
    var username: String
}

class LocalStorage: DataStorage {
    
    func loadModels<T: DataModel>() -> [T] {
        
        let users = [User(id: "1", username: "John"),
                     User(id: "2", username: "Anna")]
        
        return users as! [T]
    }
}

class RemoteStorage: DataStorage {
    
    func loadModels<T: DataModel>() -> [T] {
        
        let users = [User(id: "1", username: "John"),
                     User(id: "2", username: "Anna"),
                     User(id: "3", username: "Stive"),
                     User(id: "4", username: "Emma")]
        
        return users as! [T]
    }
}

class Controller {
    
    private var dataStorage: DataStorage?
    
    func setDataStorage(_ dataStorage: DataStorage) {
        
        self.dataStorage = dataStorage
    }
    
    func displayModels() {
        guard let dataStorage else { return }
        
        let models: [User] = dataStorage.loadModels()
        
        print("\nDisplaying models...")
        models.forEach({ print($0) })
    }
}

var internetConnection: Bool = false {
    didSet { print("\ninternetConnection is", internetConnection) }
}
                   
let controller = Controller()

/// Helper method
func setDataStorage() {
    if internetConnection {
        controller.setDataStorage(RemoteStorage())
    } else {
        controller.setDataStorage(LocalStorage())
    }
}

internetConnection = false

setDataStorage()
controller.displayModels()

internetConnection = true

setDataStorage()
controller.displayModels()


// prints

// internetConnection is false

// Displaying models...
// User(id: "1", username: "John")
// User(id: "2", username: "Anna")

// internetConnection is true

// Displaying models...
// User(id: "1", username: "John")
// User(id: "2", username: "Anna")
// User(id: "3", username: "Stive")
// User(id: "4", username: "Emma")
