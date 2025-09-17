import Foundation

// Book object to outline book structure in library (Non observable object)
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
