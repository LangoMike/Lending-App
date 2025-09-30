import SwiftUI

// View to display lending receipts and borrowed books
struct ReceiptView: View {
    @ObservedObject var bookStore: BookStore
    
    var body: some View {
        NavigationView {
            if bookStore.borrowedBooks.isEmpty {
                // Empty state
                VStack(spacing: 16) {
                    Image(systemName: "book.closed")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    Text("No books currently borrowed")
                        .font(.title2)
                        .foregroundColor(.gray)
                    Text("Borrow a book to see lending receipts here")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(bookStore.borrowedBooks) { book in
                        ReceiptRowView(book: book)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Lending Receipts")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Row view for receipt display
struct ReceiptRowView: View {
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Book information
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
                
                // Status indicator
                VStack(alignment: .trailing, spacing: 4) {
                    Circle()
                        .fill(book.isOverdue ? Color.red : Color.orange)
                        .frame(width: 8, height: 8)
                    
                    Text(book.isOverdue ? "Overdue" : "Borrowed")
                        .font(.caption)
                        .foregroundColor(book.isOverdue ? .red : .orange)
                }
            }
            
            Divider()
            
            // Lending information
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "calendar.badge.plus")
                        .foregroundColor(.blue)
                        .frame(width: 20)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Lending Date")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(book.formattedLendingDate)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    
                    Spacer()
                }
                
                HStack {
                    Image(systemName: "calendar.badge.clock")
                        .foregroundColor(book.isOverdue ? .red : .green)
                        .frame(width: 20)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Expected Return")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(book.formattedExpectedReturnDate)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(book.isOverdue ? .red : .primary)
                    }
                    
                    Spacer()
                }
                
                // Days remaining/overdue
                HStack {
                    Image(systemName: book.isOverdue ? "exclamationmark.triangle" : "clock")
                        .foregroundColor(book.isOverdue ? .red : .blue)
                        .frame(width: 20)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(book.isOverdue ? "Days Overdue" : "Days Remaining")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(daysRemainingText(for: book))
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(book.isOverdue ? .red : .blue)
                    }
                    
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
    
    // Helper function to calculate days remaining/overdue
    private func daysRemainingText(for book: Book) -> String {
        guard let expectedReturnDate = book.expectedReturnDate else { return "N/A" }
        
        let calendar = Calendar.current
        let today = Date()
        let days = calendar.dateComponents([.day], from: today, to: expectedReturnDate).day ?? 0
        
        if book.isOverdue {
            return "\(abs(days)) days"
        } else {
            return "\(days) days"
        }
    }
}

#Preview {
    ReceiptView(bookStore: BookStore())
}
