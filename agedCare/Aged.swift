
import Foundation

struct Aged {
    var name: String
    var adress: String
    var time: String
    var service: [Service]
    var allServices: [[Service]]
    var del: Bool
    var id: Int
}

struct Service {
    var name: String
    var done: Bool
    var date: String
}
