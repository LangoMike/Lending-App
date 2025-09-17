import Foundation
import SwiftUI

// ObservableObject to manage all book data in library
class BookStore: ObservableObject {
    @Published var books: [Book] = []
    @Published var searchText: String = ""
    @Published var showOnlyAvailable: Bool = false
    
    // Computed property for filtered books
    var filteredBooks: [Book] {
        var filtered = books
        
        // Filter by search text (title or author)
        if !searchText.isEmpty {
            filtered = filtered.filter { book in
                book.title.localizedCaseInsensitiveContains(searchText) ||
                book.author.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Filter by availability
        if showOnlyAvailable {
            filtered = filtered.filter { !$0.isBorrowed }
        }
        
        return filtered
    }
    
    // Initialize with sample books
    init() {
        loadSampleBooks()
    }
    
    // Adds a new book to lib
    func addBook(title: String, author: String) {
        let newBook = Book(title: title, author: author)
        books.append(newBook)
    }
    
    // Borrows a book (mark as borrowed)
    func borrowBook(_ book: Book) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index].isBorrowed = true
        }
    }
    
    // Returns a book (mark as available)
    func returnBook(_ book: Book) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index].isBorrowed = false
        }
    }
    
    // Load some sample books for demo
    private func loadSampleBooks() {
        books = [
            Book(title: "The Great Gatsby", author: "F. Scott Fitzgerald"),
            Book(title: "To Kill a Mockingbird", author: "Harper Lee"),
            Book(title: "1984", author: "George Orwell"),
            Book(title: "Pride and Prejudice", author: "Jane Austen"),
            Book(title: "The Catcher in the Rye", author: "J.D. Salinger")
        ]
        
        // Make a couple books borrowed for demo
        books[1].isBorrowed = true
        books[3].isBorrowed = true
    }
}
