import SwiftUI

// View to display wishlist and favorited books
struct WishlistView: View {
    @ObservedObject var bookStore: BookStore
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Tab selector
            Picker("View", selection: $selectedTab) {
                Text("Wishlist").tag(0)
                Text("Favorites").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Divider()
            
            // Content based on selected tab
            if selectedTab == 0 {
                // Wishlist content
                if bookStore.wishlistBooks.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "heart")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("No books in wishlist")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Text("Add books to your wishlist by tapping the heart icon")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(bookStore.wishlistBooks) { book in
                            WishlistRowView(book: book, bookStore: bookStore)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            } else {
                // Favorites content
                if bookStore.favoritedBooks.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "star")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("No favorited books")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Text("Add books to your favorites by tapping the star icon")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(bookStore.favoritedBooks) { book in
                            WishlistRowView(book: book, bookStore: bookStore)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
        .navigationTitle(selectedTab == 0 ? "Wishlist" : "Favorites")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Row view for wishlist and favorites
struct WishlistRowView: View {
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
                
                // Status indicator
                HStack {
                    Circle()
                        .fill(book.isBorrowed ? Color.red : Color.green)
                        .frame(width: 8, height: 8)
                    
                    Text(book.status)
                        .font(.caption)
                        .foregroundColor(book.isBorrowed ? .red : .green)
                }
                .padding(.top, 2)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
                // Action buttons
                HStack(spacing: 8) {
                    // Wishlist button
                    Button(action: {
                        bookStore.toggleWishlist(book)
                    }) {
                        Image(systemName: book.isInWishlist ? "heart.fill" : "heart")
                            .foregroundColor(book.isInWishlist ? .red : .gray)
                            .font(.system(size: 16))
                    }
                    
                    // Favorite button
                    Button(action: {
                        bookStore.toggleFavorite(book)
                    }) {
                        Image(systemName: book.isFavorited ? "star.fill" : "star")
                            .foregroundColor(book.isFavorited ? .yellow : .gray)
                            .font(.system(size: 16))
                    }
                    
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
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(book.isBorrowed ? Color.blue : Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(6)
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationView {
        WishlistView(bookStore: BookStore())
    }
}
