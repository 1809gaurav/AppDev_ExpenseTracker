import 'package:uuid/uuid.dart';

/// Enum for expense categories with color coding
enum ExpenseCategory {
  food('Food', 0xFF4CAF50),
  transportation('Transportation', 0xFF2196F3),
  entertainment('Entertainment', 0xFF9C27B0),
  shopping('Shopping', 0xFFFF9800),
  healthcare('Healthcare', 0xFFF44336),
  education('Education', 0xFF3F51B5),
  utilities('Utilities', 0xFF607D8B),
  other('Other', 0xFF795548);

  const ExpenseCategory(this.displayName, this.color);
  final String displayName;
  final int color;
}

/// Expense model with comprehensive data structure
class Expense {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;

  const Expense({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
  });

  /// Factory constructor to create a new expense with auto-generated ID
  factory Expense.create({
    required String title,
    required String description,
    required double amount,
    required DateTime date,
    required ExpenseCategory category,
  }) {
    return Expense(
      id: const Uuid().v4(),
      title: title,
      description: description,
      amount: amount,
      date: date,
      category: category,
    );
  }

  /// Factory constructor from JSON for persistence
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      category: ExpenseCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => ExpenseCategory.other,
      ),
    );
  }

  /// Convert to JSON for persistence
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.name,
    };
  }

  /// Create a copy with updated fields
  Expense copyWith({
    String? id,
    String? title,
    String? description,
    double? amount,
    DateTime? date,
    ExpenseCategory? category,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }

  /// Validation methods
  static bool isValidTitle(String title) {
    return title.trim().isNotEmpty && title.trim().length >= 2;
  }

  static bool isValidAmount(double amount) {
    return amount > 0;
  }

  static bool isValidDescription(String description) {
    return description.trim().isNotEmpty;
  }

  /// Get formatted amount string
  String get formattedAmount => '\$${amount.toStringAsFixed(2)}';

  /// Get formatted date string
  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Expense && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Expense(id: $id, title: $title, amount: $amount, date: $date, category: ${category.displayName})';
  }
}