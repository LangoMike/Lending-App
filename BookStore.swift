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
            books[index].lendingDate = Date()
            books[index].expectedReturnDate = Calendar.current.date(byAdding: .day, value: 7, to: Date())
        }
    }
    
    // Returns a book (mark as available)
    func returnBook(_ book: Book) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index].isBorrowed = false
            books[index].lendingDate = nil
            books[index].expectedReturnDate = nil
        }
    }
    
    // Toggle wishlist status for a book
    func toggleWishlist(_ book: Book) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index].isInWishlist.toggle()
        }
    }
    
    // Toggle favorite status for a book
    func toggleFavorite(_ book: Book) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index].isFavorited.toggle()
        }
    }
    
    // Get all books in wishlist
    var wishlistBooks: [Book] {
        return books.filter { $0.isInWishlist }
    }
    
    // Get all favorited books
    var favoritedBooks: [Book] {
        return books.filter { $0.isFavorited }
    }
    
    // Get all borrowed books (for receipts)
    var borrowedBooks: [Book] {
        return books.filter { $0.isBorrowed }
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
