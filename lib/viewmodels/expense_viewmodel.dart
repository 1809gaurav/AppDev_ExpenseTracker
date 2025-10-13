import 'package:flutter/material.dart';
import 'dart:collection';
import '../models/expense_model.dart';

class ExpenseViewModel extends ChangeNotifier {
  final List<Expense> _expenses = [];

  // Provides an unmodifiable view of the expenses list
  UnmodifiableListView<Expense> get expenses => UnmodifiableListView(_expenses);

  // Calculates total daily expenses for the chart
  Map<int, double> get dailyTotals {
    final Map<int, double> totals = {};
    for (var expense in _expenses) {
      totals.update(
        expense.date.weekday,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }
    return totals;
  }

  // Business logic to add a new expense
  void addExpense(double amount) {
    _expenses.add(Expense(amount: amount, date: DateTime.now()));
    // Notify listeners (the View) that the state has changed
    notifyListeners();
  }
}
