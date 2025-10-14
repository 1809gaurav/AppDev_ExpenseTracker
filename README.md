# Expense Tracker - Competition Starter

A Flutter application starter template for building an expense tracking app with data visualization capabilities.

## Project Overview

This is a barebones Flutter project set up for a coding competition. Your task is to build a fully functional expense tracker application that allows users to:

- Add and manage personal expenses
- Visualize spending patterns through charts
- Track expenses over time
- Categorize different types of expenses

## Getting Started

### Prerequisites
- Flutter SDK (3.8.0 or higher)
- Dart SDK (3.8.0 or higher)
- Android Studio / VS Code with Flutter extensions
- An Android/iOS device or emulator

### Installation
1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Project Structure

The project follows the MVVM (Model-View-ViewModel) architecture pattern:

```
lib/
├── main.dart              # Application entry point
├── models/                # Data models
│   └── expense_model.dart # Expense data structure
├── viewmodels/            # Business logic layer
│   └── expense_viewmodel.dart # Expense management logic
└── views/                 # UI components
    └── expense_view.dart  # Main expense screen
```

## Available Dependencies

The following packages are already included in `pubspec.yaml`:

- `provider: ^6.1.5+1` - State management
- `fl_chart: ^0.68.0` - Chart visualization
- `intl: ^0.20.2` - Internationalization and date formatting
- `cupertino_icons: ^1.0.8` - iOS-style icons

## What You Need to Build

### Core Features
1. **Expense Model** - Define the data structure for expenses
2. **Expense Management** - Add, edit, delete expenses
3. **Data Visualization** - Charts showing spending patterns
4. **User Interface** - Clean, intuitive design
5. **State Management** - Proper MVVM implementation

### Bonus Features (Optional)
- Expense categories
- Date filtering
- Export functionality
- Local data persistence
- Expense search and filtering

## Evaluation Criteria

Your solution will be evaluated based on:
- **Functionality** - Does the app work as expected?
- **Code Quality** - Clean, readable, well-structured code
- **Architecture** - Proper MVVM implementation
- **UI/UX** - User-friendly interface design
- **Innovation** - Creative features and solutions

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [FL Chart Documentation](https://pub.dev/packages/fl_chart)
- [Provider Package](https://pub.dev/packages/provider)
- [Material Design Guidelines](https://material.io/design)

## Submission Guidelines

Please refer to the competition guidelines provided separately for submission instructions and deadlines.

Good luck! 🚀