import Foundation
import SwiftUI
internal import Combine

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
            Book(title: "The Catcher in the Rye", author: "J.D. Salinger"),
            Book(title: "The Hobbit", author: "J.R.R. Tolkien"),
            Book(title: "Harry Potter and the Sorcerer's Stone", author: "J.K. Rowling"),
            Book(title: "The Lord of the Rings", author: "J.R.R. Tolkien"),
            Book(title: "Dune", author: "Frank Herbert"),
            Book(title: "The Chronicles of Narnia", author: "C.S. Lewis"),
            Book(title: "The Hunger Games", author: "Suzanne Collins"),
            Book(title: "The Handmaid's Tale", author: "Margaret Atwood"),
            Book(title: "Brave New World", author: "Aldous Huxley"),
            Book(title: "The Alchemist", author: "Paulo Coelho"),
            Book(title: "The Kite Runner", author: "Khaled Hosseini"),
            Book(title: "The Lightning Thief", author: "Rick Riordan"),
            Book(title: "The Sea of Monsters", author: "Rick Riordan"),
            Book(title: "The Titan's Curse", author: "Rick Riordan"),
            Book(title: "The Battle of the Labyrinth", author: "Rick Riordan"),
            Book(title: "The Last Olympian", author: "Rick Riordan")
        ]
        
    }
}
