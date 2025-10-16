# Expense Tracker - Competition Entry

A comprehensive Flutter expense tracking application built with MVVM architecture, featuring beautiful data visualizations, local persistence, and advanced filtering capabilities.

## 🚀 Features

### Core Features (Required)
- ✅ **Expense Management**: Add, edit, delete expenses with validation
- ✅ **Data Visualization**: Interactive pie charts and bar charts
- ✅ **MVVM Architecture**: Clean separation of concerns
- ✅ **State Management**: Provider pattern for reactive UI
- ✅ **Expense Categories**: 8 predefined categories with color coding
- ✅ **Local Persistence**: Data saved using SharedPreferences

### Bonus Features (Extra Points)
- ✅ **Advanced Filtering**: Search by title/description, filter by category and date
- ✅ **Multiple Chart Types**: Pie charts for categories, bar charts for daily spending
- ✅ **Analytics Dashboard**: Comprehensive spending insights
- ✅ **Responsive Design**: Beautiful Material Design 3 UI
- ✅ **Data Export**: CSV export functionality
- ✅ **Error Handling**: Graceful error handling with user feedback
- ✅ **Input Validation**: Comprehensive form validation
- ✅ **Empty States**: User-friendly empty state handling

## 📱 Screenshots

The app features three main tabs:
1. **Expenses Tab**: List view with summary cards and expense management
2. **Charts Tab**: Interactive pie charts and bar charts
3. **Analytics Tab**: Detailed spending analytics and insights

## 🏗️ Architecture

### MVVM Pattern Implementation
```
lib/
├── models/
│   └── expense_model.dart      # Data models with validation
├── viewmodels/
│   └── expense_viewmodel.dart  # Business logic and state management
├── views/
│   ├── expense_view.dart       # Main UI with tabs
│   ├── add_expense_dialog.dart # Add/edit expense dialog
│   └── expense_details_dialog.dart # Expense details view
└── main.dart                   # App entry point with Provider setup
```

### Key Design Patterns
- **MVVM Architecture**: Clean separation between UI and business logic
- **Provider Pattern**: Reactive state management
- **Repository Pattern**: Data persistence abstraction
- **Factory Pattern**: Expense creation with validation
- **Observer Pattern**: UI updates based on data changes

## 🛠️ Technical Implementation

### Data Model
- **Expense Model**: Comprehensive data structure with validation
- **Categories**: Enum-based categories with color coding
- **Serialization**: JSON serialization for persistence
- **Validation**: Input validation for all fields

### State Management
- **ExpenseViewModel**: Centralized business logic
- **Reactive Updates**: UI automatically updates on data changes
- **Error Handling**: Comprehensive error states
- **Loading States**: User feedback during operations

### Data Visualization
- **FL Chart Integration**: Professional chart library
- **Pie Charts**: Category-wise spending breakdown
- **Bar Charts**: Daily spending trends
- **Interactive Elements**: Tap to view details

### Persistence
- **SharedPreferences**: Local data storage
- **JSON Serialization**: Efficient data storage
- **Data Migration**: Future-proof data structure

## 🎨 UI/UX Features

### Design System
- **Material Design 3**: Modern design language
- **Color Coding**: Category-based color system
- **Typography**: Consistent text hierarchy
- **Spacing**: Proper spacing and padding
- **Elevation**: Card-based layout with shadows

### User Experience
- **Intuitive Navigation**: Tab-based navigation
- **Quick Actions**: Floating action button for adding expenses
- **Search & Filter**: Advanced filtering capabilities
- **Empty States**: Helpful empty state messages
- **Loading States**: Visual feedback during operations
- **Error Handling**: User-friendly error messages

### Responsive Design
- **Adaptive Layout**: Works on different screen sizes
- **Touch Targets**: Properly sized interactive elements
- **Accessibility**: Screen reader support
- **Dark Mode Ready**: Theme-aware color system

## 📊 Data Visualization

### Chart Types
1. **Pie Chart**: Category-wise spending breakdown
2. **Bar Chart**: Daily spending trends (last 7 days)
3. **Analytics Cards**: Key metrics and insights

### Interactive Features
- **Category Legend**: Visual category indicators
- **Date Filtering**: Time-based data filtering
- **Real-time Updates**: Charts update automatically
- **Responsive Charts**: Adapt to different screen sizes

## 🔧 Setup Instructions

### Prerequisites
- Flutter SDK (3.8.0 or higher)
- Dart SDK (3.8.0 or higher)
- Android Studio / VS Code with Flutter extensions
- An Android/iOS device or emulator

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/1809gaurav/AppDev_ExpenseTracker.git
   cd AppDev_ExpenseTracker
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```

### Dependencies
- `provider: ^6.1.5+1` - State management
- `fl_chart: ^0.68.0` - Chart visualization
- `intl: ^0.20.2` - Internationalization and date formatting
- `shared_preferences: ^2.2.2` - Local data persistence
- `uuid: ^4.2.1` - Unique ID generation
- `cupertino_icons: ^1.0.8` - iOS-style icons

## 🧪 Testing

### Manual Testing Checklist
- [ ] Add new expense with all fields
- [ ] Edit existing expense
- [ ] Delete expense with confirmation
- [ ] Search expenses by title/description
- [ ] Filter by category
- [ ] Filter by date
- [ ] View charts and analytics
- [ ] Data persistence across app restarts
- [ ] Error handling for invalid inputs
- [ ] Empty state handling

### Test Scenarios
1. **Data Entry**: Test all form validations
2. **CRUD Operations**: Create, read, update, delete expenses
3. **Filtering**: Test search and filter functionality
4. **Charts**: Verify chart data accuracy
5. **Persistence**: Test data saving and loading
6. **Error Handling**: Test edge cases and error scenarios

## 🏆 Competition Highlights

### Technical Excellence
- **Clean Architecture**: Proper MVVM implementation
- **Code Quality**: Well-documented, readable code
- **Error Handling**: Comprehensive error management
- **Performance**: Efficient data handling and UI updates
- **Scalability**: Extensible architecture for future features

### Innovation
- **Advanced Filtering**: Multi-criteria filtering system
- **Data Export**: CSV export functionality
- **Analytics Dashboard**: Comprehensive spending insights
- **Responsive Design**: Adaptive UI for different screen sizes
- **User Experience**: Intuitive and polished interface

### Bonus Features Implemented
- ✅ Expense categories with color coding
- ✅ Advanced search and filtering
- ✅ Multiple chart types (pie and bar charts)
- ✅ Data export functionality
- ✅ Local data persistence
- ✅ Analytics dashboard
- ✅ Responsive design
- ✅ Error handling and validation
- ✅ Empty state handling
- ✅ Loading states and user feedback

## 📈 Future Enhancements

### Potential Improvements
- **Dark Mode**: Theme switching capability
- **Data Backup**: Cloud backup and sync
- **Budget Tracking**: Set and monitor spending budgets
- **Recurring Expenses**: Support for recurring transactions
- **Photo Attachments**: Add receipts and photos
- **Multi-Currency**: Support for different currencies
- **Advanced Analytics**: More detailed spending insights
- **Export Options**: PDF and Excel export
- **Offline Support**: Enhanced offline capabilities

## 🤝 Contributing

This project was built for a Flutter competition. The codebase demonstrates:
- Clean architecture principles
- Best practices in Flutter development
- Comprehensive feature implementation
- Professional UI/UX design
- Robust error handling and validation

## 📄 License

This project is part of a Flutter development competition and showcases modern Flutter development practices.

---

**Built with ❤️ using Flutter and Material Design 3**