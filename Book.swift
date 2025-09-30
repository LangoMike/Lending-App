import Foundation

// Book object to outline book structure in library (Non observable object)
struct Book: Identifiable, Codable {
    let id = UUID()
    var title: String
    var author: String
    var isBorrowed: Bool = false
    var isInWishlist: Bool = false
    var isFavorited: Bool = false
    var lendingDate: Date?
    var expectedReturnDate: Date?
    
    // get status as string
    var status: String {
        return isBorrowed ? "Borrowed" : "Available"
    }
    
    // get status color
    var statusColor: String {
        return isBorrowed ? "red" : "green"
    }
    
    // Formatted lending date
    var formattedLendingDate: String {
        guard let lendingDate = lendingDate else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: lendingDate)
    }
    
    // Formatted expected return date
    var formattedExpectedReturnDate: String {
        guard let expectedReturnDate = expectedReturnDate else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: expectedReturnDate)
    }
    
    // Check if book is overdue
    var isOverdue: Bool {
        guard let expectedReturnDate = expectedReturnDate else { return false }
        return Date() > expectedReturnDate
    }
}
