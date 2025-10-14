import 'package:flutter/material.dart';

// TODO: Create your ExpenseView widget here
// This should be the main screen for displaying and managing expenses
// Consider implementing:
// - A list view to show expenses
// - A chart to visualize spending patterns
// - Forms to add new expenses
// - Integration with your ExpenseViewModel

class ExpenseView extends StatelessWidget {
  const ExpenseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: const Center(
        child: Text('TODO: Implement expense view'),
      ),
    );
  }
}