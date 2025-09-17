# Lending App (CS 3714 LAB 2)

A simple iOS app built with SwiftUI that allows users to manage a library of books, including borrowing and returning functionality.

## Features

- **View All Books**: Display a list of all books with title, author, and availability status
- **Add New Books**: Add books to the library with a simple form
- **Borrow/Return Books**: Toggle book availability with intuitive buttons
- **Visual Status Indicator**: Color-coded status indicators (green for available, red for borrowed)
  
# Additional Features (We can add more on thursday)
- **Search Bar**: Search bar to allow for filtering by title / author
- **Filter**: Enables users to filter books based on availability

## Project Structure

- `LendingApp.swift` - Main app entry point
- `Book.swift` - Book data model
- `BookStore.swift` - ObservableObject managing the library data
- `BookListView.swift` - Main view for displaying the list of books
- `AddBookView.swift` - Form for adding new books


## Key SwiftUI Concepts Used

- **@StateObject** and **@ObservedObject** for data management
- **@Published** properties for reactive UI updates
- **NavigationView** and **NavigationLink** for navigation
- **List** and **ForEach** for displaying collections
- **Form** for input forms
- **Toolbar** for navigation bar buttons
