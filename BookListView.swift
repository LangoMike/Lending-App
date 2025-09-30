import SwiftUI

// Main screen view to display all books in library
struct BookListView: View {
    @StateObject private var bookStore = BookStore()
    @State private var showingAddBook = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                SearchBar(text: $bookStore.searchText)
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                // Filter Toggle
                HStack {
                    Toggle("Show Only Available", isOn: $bookStore.showOnlyAvailable)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    Spacer()
                }
                
                Divider()
                
                // Book List
                List {
                    ForEach(bookStore.filteredBooks) { book in
                        BookRowView(book: book, bookStore: bookStore)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Library")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 16) {
                        NavigationLink(destination: WishlistView(bookStore: bookStore)) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }
                        
                        NavigationLink(destination: ReceiptView(bookStore: bookStore)) {
                            Image(systemName: "doc.text")
                                .foregroundColor(.blue)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Book") {
                        showingAddBook = true
                    }
                }
            }
            .sheet(isPresented: $showingAddBook) {
                AddBookView(bookStore: bookStore)
            }
        }
    }
}

struct BookRowView: View {
    let book: Book
    let bookStore: BookStore
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("by \(book.author)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
                // Status indicator with color
                VStack(alignment: .trailing, spacing: 4) {
                    HStack {
                        Circle()
                            .fill(book.isBorrowed ? (book.isOverdue ? Color.red : Color.orange) : Color.green)
                            .frame(width: 8, height: 8)
                        
                        Text(book.isBorrowed ? (book.isOverdue ? "Overdue" : "Borrowed") : "Available")
                            .font(.caption)
                            .foregroundColor(book.isBorrowed ? (book.isOverdue ? .red : .orange) : .green)
                    }
                    
                    // Show lending info if borrowed
                    if book.isBorrowed {
                        Text("Due: \(book.formattedExpectedReturnDate)")
                            .font(.caption2)
                            .foregroundColor(book.isOverdue ? .red : .secondary)
                    }
                }
                
                // Action buttons row
                HStack(spacing: 12) {
                    // Wishlist button
                    Button(action: {
                        bookStore.toggleWishlist(book)
                    }) {
                        Image(systemName: book.isInWishlist ? "heart.fill" : "heart")
                            .foregroundColor(book.isInWishlist ? .red : .gray)
                            .font(.system(size: 16))
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // Favorite button
                    Button(action: {
                        bookStore.toggleFavorite(book)
                    }) {
                        Image(systemName: book.isFavorited ? "star.fill" : "star")
                            .foregroundColor(book.isFavorited ? .yellow : .gray)
                            .font(.system(size: 16))
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // Borrow/Return button
                    Button(action: {
                        if book.isBorrowed {
                            bookStore.returnBook(book)
                        } else {
                            bookStore.borrowBook(book)
                        }
                    }) {
                        Text(book.isBorrowed ? "Return" : "Borrow")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(book.isBorrowed ? Color.blue : Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(6)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search books by title or author...", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    BookListView()
}
