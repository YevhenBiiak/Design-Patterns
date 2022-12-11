import Foundation

protocol Observable {
    func add(observer: Observer)
    func remove(observer: Observer)
    func notifyObservers()
}

protocol Observer {
    var id: String { get set }
    func update(news: String)
}

class NewsResource: Observable {
    private var observers: [Observer] = []
    private var news = String() {
        didSet { notifyObservers() }
    }
    
    func nextNews() {
        self.news = Date().description
    }
    
    func add(observer: Observer) {
        observers.append(observer)
    }
    
    func remove(observer: Observer) {
        observers.removeAll { $0.id == observer.id }
    }
    
    func notifyObservers() {
        observers.forEach { $0.update(news: news) }
        print()
    }
}

class NewsAgency: Observer {
    
    var id: String = "News Agency"
    
    func update(news: String) {
        print("News Agency. Did recive news", news)
    }
}

class Reporter: Observer {
    
    var id: String = "Reporter"
    
    func update(news: String) {
        print("Reporter. New reportage about news:", news)
    }
}

class Blogger: Observer {
    
    var id: String = "Blogger"
    
    func update(news: String) {
        print("Blogger. New articule about news:", news)
    }
}

let resource = NewsResource()

let agency = NewsAgency()
let reporter = Reporter()
let blogger = Blogger()

resource.add(observer: agency)
resource.add(observer: reporter)
resource.add(observer: blogger)

resource.nextNews()

resource.remove(observer: blogger)

resource.nextNews()

// prints

// News Agency. Did recive news 2022-12-11 08:54:11 +0000
// Reporter. New reportage about news: 2022-12-11 08:54:11 +0000
// Blogger. New articule about news: 2022-12-11 08:54:11 +0000

// News Agency. Did recive news 2022-12-11 08:54:11 +0000
// Reporter. New reportage about news: 2022-12-11 08:54:11 +0000
