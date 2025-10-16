import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/expense_model.dart';

/// ViewModel for managing expense data and business logic
class ExpenseViewModel extends ChangeNotifier {
  List<Expense> _expenses = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  ExpenseCategory? _selectedCategory;
  DateTime? _selectedDate;

  // Getters
  List<Expense> get expenses => _expenses;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  ExpenseCategory? get selectedCategory => _selectedCategory;
  DateTime? get selectedDate => _selectedDate;

  /// Get filtered expenses based on search and category
  List<Expense> get filteredExpenses {
    List<Expense> filtered = _expenses;

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((expense) =>
          expense.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          expense.description.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

    // Filter by category
    if (_selectedCategory != null) {
      filtered = filtered.where((expense) => expense.category == _selectedCategory).toList();
    }

    // Filter by date
    if (_selectedDate != null) {
      filtered = filtered.where((expense) =>
          expense.date.year == _selectedDate!.year &&
          expense.date.month == _selectedDate!.month &&
          expense.date.day == _selectedDate!.day
      ).toList();
    }

    // Sort by date (newest first)
    filtered.sort((a, b) => b.date.compareTo(a.date));
    return filtered;
  }

  /// Get total expenses amount
  double get totalAmount {
    return _expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  /// Get expenses by category for charts
  Map<ExpenseCategory, double> get expensesByCategory {
    Map<ExpenseCategory, double> categoryTotals = {};
    for (ExpenseCategory category in ExpenseCategory.values) {
      categoryTotals[category] = 0.0;
    }
    
    for (Expense expense in _expenses) {
      categoryTotals[expense.category] = 
          (categoryTotals[expense.category] ?? 0.0) + expense.amount;
    }
    
    return categoryTotals;
  }

  /// Get expenses by date for time-based charts
  Map<DateTime, double> get expensesByDate {
    Map<DateTime, double> dateTotals = {};
    
    for (Expense expense in _expenses) {
      DateTime dateKey = DateTime(expense.date.year, expense.date.month, expense.date.day);
      dateTotals[dateKey] = (dateTotals[dateKey] ?? 0.0) + expense.amount;
    }
    
    return dateTotals;
  }

  /// Initialize and load data
  Future<void> initialize() async {
    _setLoading(true);
    try {
      await _loadExpenses();
      _clearError();
    } catch (e) {
      _setError('Failed to load expenses: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Add a new expense
  Future<void> addExpense(Expense expense) async {
    try {
      _expenses.add(expense);
      await _saveExpenses();
      notifyListeners();
    } catch (e) {
      _setError('Failed to add expense: $e');
    }
  }

  /// Update an existing expense
  Future<void> updateExpense(Expense updatedExpense) async {
    try {
      final index = _expenses.indexWhere((expense) => expense.id == updatedExpense.id);
      if (index != -1) {
        _expenses[index] = updatedExpense;
        await _saveExpenses();
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to update expense: $e');
    }
  }

  /// Delete an expense
  Future<void> deleteExpense(String expenseId) async {
    try {
      _expenses.removeWhere((expense) => expense.id == expenseId);
      await _saveExpenses();
      notifyListeners();
    } catch (e) {
      _setError('Failed to delete expense: $e');
    }
  }

  /// Set search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  /// Set selected category filter
  void setSelectedCategory(ExpenseCategory? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  /// Set selected date filter
  void setSelectedDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }

  /// Clear all filters
  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    _selectedDate = null;
    notifyListeners();
  }

  /// Get expenses for a specific month
  List<Expense> getExpensesForMonth(DateTime month) {
    return _expenses.where((expense) =>
        expense.date.year == month.year && expense.date.month == month.month
    ).toList();
  }

  /// Get total for a specific month
  double getTotalForMonth(DateTime month) {
    return getExpensesForMonth(month).fold(0.0, (sum, expense) => sum + expense.amount);
  }

  /// Export expenses to CSV format
  String exportToCSV() {
    if (_expenses.isEmpty) return '';

    StringBuffer csv = StringBuffer();
    csv.writeln('Date,Title,Description,Amount,Category');
    
    for (Expense expense in _expenses) {
      csv.writeln('${expense.formattedDate},"${expense.title}","${expense.description}",${expense.amount},"${expense.category.displayName}"');
    }
    
    return csv.toString();
  }

  /// Private methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }

  /// Load expenses from SharedPreferences
  Future<void> _loadExpenses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final expensesJson = prefs.getStringList('expenses') ?? [];
      
      _expenses = expensesJson
          .map((jsonString) => Expense.fromJson(jsonDecode(jsonString)))
          .toList();
    } catch (e) {
      throw Exception('Failed to load expenses: $e');
    }
  }

  /// Save expenses to SharedPreferences
  Future<void> _saveExpenses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final expensesJson = _expenses
          .map((expense) => jsonEncode(expense.toJson()))
          .toList();
      
      await prefs.setStringList('expenses', expensesJson);
    } catch (e) {
      throw Exception('Failed to save expenses: $e');
    }
  }

  /// Clear all data (for testing or reset)
  Future<void> clearAllData() async {
    try {
      _expenses.clear();
      await _saveExpenses();
      notifyListeners();
    } catch (e) {
      _setError('Failed to clear data: $e');
    }
  }
}