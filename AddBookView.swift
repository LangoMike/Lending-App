import SwiftUI

// Handles adding a new book to the library
// Displays as a form

struct AddBookView: View {
    @ObservedObject var bookStore: BookStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var author = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Details")) {
                    TextField("Book Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Author", text: $author)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section {
                    Button("Add Book") {
                        if !title.isEmpty && !author.isEmpty {
                            bookStore.addBook(title: title, author: author)
                            dismiss()
                        }
                    }
                    .disabled(title.isEmpty || author.isEmpty)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(title.isEmpty || author.isEmpty ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .navigationTitle("Add New Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddBookView(bookStore: BookStore())
}
