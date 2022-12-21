import Foundation

protocol DomainModel {}

protocol QueryBuilder {
    associatedtype Model
    
    func filter(_ predicate: @escaping (Model) -> Bool) -> Self
    func limit(_ limit: Int) -> Self
    func fetch() -> [Model]
}

class RealmQueryBuilder<Model: DomainModel>: QueryBuilder {
    
    enum Query {
        case filter(predicate: (Model) -> Bool)
        case limit(Int)
    }
    
    private var queries: [Query] = []
    
    @discardableResult
    func filter(_ predicate: @escaping (Model) -> Bool) -> Self {
        queries.append(Query.filter(predicate: predicate))
        return self
    }
    
    @discardableResult
    func limit(_ limit: Int) -> Self {
        queries.append(Query.limit(limit))
        return self
    }
    
    func fetch() -> [Model] {
        let realmProvider = RealmProvider()
        return realmProvider.fetch(queries: queries)
    }
}

class CoreDataQueryBuilder<Model: DomainModel>: QueryBuilder {
    
    enum Query {
        case filter(predicate: (Model) -> Bool)
        case limit(Int)
    }
    
    private var queries: [Query] = []
    
    @discardableResult
    func filter(_ predicate: @escaping (Model) -> Bool) -> Self {
        queries.append(Query.filter(predicate: predicate))
        return self
    }
    
    @discardableResult
    func limit(_ limit: Int) -> Self {
        queries.append(Query.limit(limit))
        return self
    }
    
    func fetch() -> [Model] {
        let сoreDataProvider = CoreDataProvider()
        return сoreDataProvider.fetch(queries: queries)
    }
}

class RealmProvider {
    
    func fetch<Model: DomainModel>(queries: [RealmQueryBuilder<Model>.Query]) -> [Model] {
        print("RealmProvider: Retrieving data from Realm...")
        
        if Model.self is User.Type {
            var users = User.testSet as! [Model]
            
            for query in queries {
                switch query {
                case let .filter(predicate):
                    print("RealmProvider: apply filter...")
                    users = users.filter(predicate)
                case let .limit(limit):
                    print("RealmProvider: apply limit...")
                    users = Array(users.prefix(limit))
                }
            }
            
            return users
        }
        return []
    }
}

class CoreDataProvider {
    
    func fetch<Model: DomainModel>(queries: [CoreDataQueryBuilder<Model>.Query]) -> [Model] {
        print("CoreDataProvider: Retrieving data from CoreData...")
        
        if Model.self is User.Type {
            var users = User.testSet as! [Model]
            
            for query in queries {
                switch query {
                case let .filter(predicate):
                    print("CoreDataProvider: apply filter...")
                    users = users.filter(predicate)
                case let .limit(limit):
                    print("CoreDataProvider: apply limit...")
                    users = Array(users.prefix(limit))
                }
            }
            
            return users
        }
        return []
    }
}

struct User: DomainModel {
    let id: Int
    let name: String
}

extension User: CustomStringConvertible {
    
    var description: String {
        return "User(id: \(id), name: \(name))"
    }
    
    static var testSet: [User] {[
        User(id: 0, name: "John"),
        User(id: 1, name: "Anna"),
        User(id: 2, name: "Maria"),
        User(id: 3, name: "Jack"),
        User(id: 4, name: "Stive"),
        User(id: 5, name: "Mark"),
        User(id: 6, name: "Andrew"),
        User(id: 7, name: "Lili"),
        User(id: 8, name: "Lia"),
        User(id: 9, name: "Martin"),
        User(id: 10, name: "Coul"),
        User(id: 11, name: "Jenifer"),
        User(id: 12, name: "Matthew"),
        User(id: 13, name: "Elizabet"),
        User(id: 14, name: "Sandra"),
        User(id: 15, name: "Derek")
    ]}
}

print("\nClient: Start fetching data from Realm")

let realmBuilder = RealmQueryBuilder<User>()
let realmResult = realmBuilder.filter({ $0.name.starts(with: "M") })
    .limit(5)
    .fetch()

print(realmResult)


print("\nClient: Start fetching data from CoreData")

let coreDataBuilder = CoreDataQueryBuilder<User>()
let coreDataResults = coreDataBuilder.filter({ $0.id > 5 })
    .limit(4)
    .fetch()

print(coreDataResults)

// prints

// Client: Start fetching data from Realm
// RealmProvider: Retrieving data from Realm...
// RealmProvider: apply filter...
// RealmProvider: apply limit...
// [User(id: 2, name: Maria), User(id: 5, name: Mark), User(id: 9, name: Martin), User(id: 12, name: Matthew)]

// Client: Start fetching data from CoreData
// CoreDataProvider: Retrieving data from CoreData...
// CoreDataProvider: apply filter...
// CoreDataProvider: apply limit...
// [User(id: 6, name: Andrew), User(id: 7, name: Lili), User(id: 8, name: Lia), User(id: 9, name: Martin)]
