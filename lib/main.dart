// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/expense_viewmodel.dart';
import 'views/expense_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide the ViewModel to the widget tree
    return ChangeNotifierProvider(
      create: (context) => ExpenseViewModel(),
      child: MaterialApp(
        title: 'Expense Tracker (MVVM)',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const ExpenseView(),
      ),
    );
  }
}
