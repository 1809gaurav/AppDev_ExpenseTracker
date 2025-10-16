import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../lib/models/expense_model.dart';
import '../lib/viewmodels/expense_viewmodel.dart';

void main() {
  group('Expense Model Tests', () {
    test('should create expense with valid data', () {
      final expense = Expense.create(
        title: 'Test Expense',
        description: 'Test Description',
        amount: 100.0,
        date: DateTime.now(),
        category: ExpenseCategory.food,
      );

      expect(expense.title, 'Test Expense');
      expect(expense.description, 'Test Description');
      expect(expense.amount, 100.0);
      expect(expense.category, ExpenseCategory.food);
      expect(expense.id.isNotEmpty, true);
    });

    test('should validate title correctly', () {
      expect(Expense.isValidTitle('Valid Title'), true);
      expect(Expense.isValidTitle('A'), false);
      expect(Expense.isValidTitle(''), false);
      expect(Expense.isValidTitle('   '), false);
    });

    test('should validate amount correctly', () {
      expect(Expense.isValidAmount(100.0), true);
      expect(Expense.isValidAmount(0.0), false);
      expect(Expense.isValidAmount(-10.0), false);
    });

    test('should validate description correctly', () {
      expect(Expense.isValidDescription('Valid Description'), true);
      expect(Expense.isValidDescription(''), false);
      expect(Expense.isValidDescription('   '), false);
    });

    test('should serialize and deserialize correctly', () {
      final originalExpense = Expense.create(
        title: 'Test Expense',
        description: 'Test Description',
        amount: 100.0,
        date: DateTime(2023, 1, 1),
        category: ExpenseCategory.food,
      );

      final json = originalExpense.toJson();
      final deserializedExpense = Expense.fromJson(json);

      expect(deserializedExpense.title, originalExpense.title);
      expect(deserializedExpense.description, originalExpense.description);
      expect(deserializedExpense.amount, originalExpense.amount);
      expect(deserializedExpense.date, originalExpense.date);
      expect(deserializedExpense.category, originalExpense.category);
    });

    test('should format amount correctly', () {
      final expense = Expense.create(
        title: 'Test',
        description: 'Test',
        amount: 123.45,
        date: DateTime.now(),
        category: ExpenseCategory.food,
      );

      expect(expense.formattedAmount, '\$123.45');
    });

    test('should format date correctly', () {
      final expense = Expense.create(
        title: 'Test',
        description: 'Test',
        amount: 100.0,
        date: DateTime(2023, 12, 25),
        category: ExpenseCategory.food,
      );

      expect(expense.formattedDate, '25/12/2023');
    });
  });

  group('ExpenseViewModel Tests', () {
    late ExpenseViewModel viewModel;

    setUp(() {
      viewModel = ExpenseViewModel();
    });

    test('should initialize with empty expenses', () {
      expect(viewModel.expenses, isEmpty);
      expect(viewModel.totalAmount, 0.0);
      expect(viewModel.isLoading, false);
      expect(viewModel.error, null);
    });

    test('should add expense correctly', () async {
      final expense = Expense.create(
        title: 'Test Expense',
        description: 'Test Description',
        amount: 100.0,
        date: DateTime.now(),
        category: ExpenseCategory.food,
      );

      await viewModel.addExpense(expense);

      expect(viewModel.expenses.length, 1);
      expect(viewModel.expenses.first, expense);
      expect(viewModel.totalAmount, 100.0);
    });

    test('should update expense correctly', () async {
      final expense = Expense.create(
        title: 'Test Expense',
        description: 'Test Description',
        amount: 100.0,
        date: DateTime.now(),
        category: ExpenseCategory.food,
      );

      await viewModel.addExpense(expense);

      final updatedExpense = expense.copyWith(
        title: 'Updated Title',
        amount: 200.0,
      );

      await viewModel.updateExpense(updatedExpense);

      expect(viewModel.expenses.length, 1);
      expect(viewModel.expenses.first.title, 'Updated Title');
      expect(viewModel.expenses.first.amount, 200.0);
      expect(viewModel.totalAmount, 200.0);
    });

    test('should delete expense correctly', () async {
      final expense = Expense.create(
        title: 'Test Expense',
        description: 'Test Description',
        amount: 100.0,
        date: DateTime.now(),
        category: ExpenseCategory.food,
      );

      await viewModel.addExpense(expense);
      expect(viewModel.expenses.length, 1);

      await viewModel.deleteExpense(expense.id);
      expect(viewModel.expenses.length, 0);
      expect(viewModel.totalAmount, 0.0);
    });

    test('should filter expenses by search query', () async {
      final expense1 = Expense.create(
        title: 'Food Expense',
        description: 'Lunch',
        amount: 50.0,
        date: DateTime.now(),
        category: ExpenseCategory.food,
      );

      final expense2 = Expense.create(
        title: 'Transport Expense',
        description: 'Taxi',
        amount: 30.0,
        date: DateTime.now(),
        category: ExpenseCategory.transportation,
      );

      await viewModel.addExpense(expense1);
      await viewModel.addExpense(expense2);

      viewModel.setSearchQuery('Food');
      expect(viewModel.filteredExpenses.length, 1);
      expect(viewModel.filteredExpenses.first.title, 'Food Expense');

      viewModel.setSearchQuery('Taxi');
      expect(viewModel.filteredExpenses.length, 1);
      expect(viewModel.filteredExpenses.first.title, 'Transport Expense');

      viewModel.setSearchQuery('');
      expect(viewModel.filteredExpenses.length, 2);
    });

    test('should filter expenses by category', () async {
      final expense1 = Expense.create(
        title: 'Food Expense',
        description: 'Lunch',
        amount: 50.0,
        date: DateTime.now(),
        category: ExpenseCategory.food,
      );

      final expense2 = Expense.create(
        title: 'Transport Expense',
        description: 'Taxi',
        amount: 30.0,
        date: DateTime.now(),
        category: ExpenseCategory.transportation,
      );

      await viewModel.addExpense(expense1);
      await viewModel.addExpense(expense2);

      viewModel.setSelectedCategory(ExpenseCategory.food);
      expect(viewModel.filteredExpenses.length, 1);
      expect(viewModel.filteredExpenses.first.category, ExpenseCategory.food);

      viewModel.setSelectedCategory(null);
      expect(viewModel.filteredExpenses.length, 2);
    });

    test('should calculate expenses by category correctly', () async {
      final expense1 = Expense.create(
        title: 'Food Expense 1',
        description: 'Lunch',
        amount: 50.0,
        date: DateTime.now(),
        category: ExpenseCategory.food,
      );

      final expense2 = Expense.create(
        title: 'Food Expense 2',
        description: 'Dinner',
        amount: 75.0,
        date: DateTime.now(),
        category: ExpenseCategory.food,
      );

      final expense3 = Expense.create(
        title: 'Transport Expense',
        description: 'Taxi',
        amount: 30.0,
        date: DateTime.now(),
        category: ExpenseCategory.transportation,
      );

      await viewModel.addExpense(expense1);
      await viewModel.addExpense(expense2);
      await viewModel.addExpense(expense3);

      final categoryData = viewModel.expensesByCategory;
      expect(categoryData[ExpenseCategory.food], 125.0);
      expect(categoryData[ExpenseCategory.transportation], 30.0);
    });

    test('should export to CSV correctly', () async {
      final expense = Expense.create(
        title: 'Test Expense',
        description: 'Test Description',
        amount: 100.0,
        date: DateTime(2023, 1, 1),
        category: ExpenseCategory.food,
      );

      await viewModel.addExpense(expense);

      final csv = viewModel.exportToCSV();
      expect(csv.contains('Date,Title,Description,Amount,Category'), true);
      expect(csv.contains('Test Expense'), true);
      expect(csv.contains('Test Description'), true);
      expect(csv.contains('100.0'), true);
      expect(csv.contains('Food'), true);
    });

    test('should clear filters correctly', () async {
      final expense = Expense.create(
        title: 'Test Expense',
        description: 'Test Description',
        amount: 100.0,
        date: DateTime.now(),
        category: ExpenseCategory.food,
      );

      await viewModel.addExpense(expense);

      viewModel.setSearchQuery('Test');
      viewModel.setSelectedCategory(ExpenseCategory.food);
      viewModel.setSelectedDate(DateTime.now());

      expect(viewModel.searchQuery, 'Test');
      expect(viewModel.selectedCategory, ExpenseCategory.food);
      expect(viewModel.selectedDate, isNotNull);

      viewModel.clearFilters();

      expect(viewModel.searchQuery, '');
      expect(viewModel.selectedCategory, null);
      expect(viewModel.selectedDate, null);
    });
  });

  group('Widget Tests', () {
    testWidgets('should display expense list correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => ExpenseViewModel(),
          child: const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Expense Tracker'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Expense Tracker'), findsOneWidget);
    });
  });
}
