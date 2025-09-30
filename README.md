# Lending App (CS 3714 LAB 3)

A basic iOS app built with SwiftUI that allows users to manage a library of books with advanced lending features, personalization, and tracking capabilities. It comes with 20 pre-loaded books along with a form for users to add any desired books.

## Core Features

- **View All Books**: Display a list of all books with title, author, and availability status
- **Add New Books**: Add books to the library with a simple form
- **Borrow/Return Books**: Toggle book availability with intuitive buttons
- **Visual Status Indicators**: Color-coded status indicators (green for available, orange for borrowed, red for overdue)
  
## Advanced Features

### Search & Filter
- **Search Bar**: Search books by title or author with real-time filtering
- **Availability Filter**: Toggle to show only available books

### Personalization
- **Wishlist**: Add books to your wishlist using the heart icon
- **Favorites**: Mark books as favorites using the star icon
- **Dedicated Wishlist View**: Browse all wishlisted and favorited books in separate tabs

### Lending Management
- **Lending Receipts**: Track all borrowed books with detailed lending information
- **Automatic Date Tracking**: Lending date and expected return date (7 days) automatically set
- **Overdue Detection**: Visual indicators when books are past their return date
- **Days Remaining/Overdue**: Real-time calculation of days until due or days overdue
- **Receipt View**: Dedicated screen showing all borrowed books with full lending details

## Project Structure

- `LendingApp.swift` - Main app entry point with @main attribute
- `Book.swift` - Book data model with properties for borrowing, wishlist, favorites, and dates
- `BookStore.swift` - ObservableObject managing all library data and business logic
- `BookListView.swift` - Main view displaying the book list with search and filter
- `AddBookView.swift` - Modal form for adding new books to the library
- `WishlistView.swift` - View for browsing wishlist and favorited books
- `ReceiptView.swift` - View for tracking borrowed books and lending information


## Key SwiftUI Concepts Used

- **@StateObject** and **@ObservedObject** for reactive data management
- **@Published** properties for automatic UI updates
- **NavigationView** and **NavigationLink** for multi-screen navigation
- **List** and **ForEach** for efficient scrollable collections
- **Form** and **TextField** for user input
- **Toolbar** for navigation bar buttons
- **Sheet** for modal presentations
- **Computed Properties** for derived data (filteredBooks, formattedDates, isOverdue)
- **Date** and **DateFormatter** for lending date management
- **Toggle** for filter controls
- **Button** with custom styling for actions

## TODO:
- Create app name / logo
- Add color + Design UI/UX to add a modern feel
- Data persistence (save/load books between app launches)
- User profiles for multiple borrowers
- Book covers/images
- Add new item sections (Expand from just books)

