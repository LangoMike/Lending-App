import Foundation

// Book model representing a book in the library
struct Book: Identifiable, Codable {
    let id = UUID()
    var title: String
    var author: String
    var isBorrowed: Bool = false
    
    // get status as string
    var status: String {
        return isBorrowed ? "Borrowed" : "Available"
    }
    
    // get status color
    var statusColor: String {
        return isBorrowed ? "red" : "green"
    }
}
