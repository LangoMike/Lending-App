import SwiftUI

struct BookListView: View {
    @StateObject private var bookStore = BookStore()
    @State private var showingAddBook = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(bookStore.books) { book in
                    BookRowView(book: book, bookStore: bookStore)
                }
            }
            .navigationTitle("Library")
            .toolbar {
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
                HStack {
                    Circle()
                        .fill(book.isBorrowed ? Color.red : Color.green)
                        .frame(width: 8, height: 8)
                    
                    Text(book.status)
                        .font(.caption)
                        .foregroundColor(book.isBorrowed ? .red : .green)
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
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(book.isBorrowed ? Color.blue : Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    BookListView()
}
