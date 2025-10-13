// views/expense_view.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../viewmodels/expense_viewmodel.dart';

class ExpenseView extends StatelessWidget {
  const ExpenseView({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseViewModel = Provider.of<ExpenseViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Expense Tracker (MVVM)')),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: expenseViewModel.dailyTotals.values.isEmpty
                      ? 100
                      : expenseViewModel.dailyTotals.values.reduce(
                              (a, b) => a > b ? a : b,
                            ) *
                            1.2,
                  barGroups: expenseViewModel.dailyTotals.entries
                      .map(
                        (entry) => BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                              toY: entry.value,
                              color: Colors.blue,
                              width: 16,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                  titlesData: FlTitlesData(
                    // Hide top and right titles
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    // Configure bottom titles (X-axis)
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30, // Space for the titles
                        // This function is called by fl_chart to get the widget for each title.
                        // It provides the numeric 'value' (e.g., 1 for Monday) and the 'meta' object.
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          );
                          String text;
                          switch (value.toInt()) {
                            case 1:
                              text = 'Mon';
                              break;
                            case 2:
                              text = 'Tue';
                              break;
                            case 3:
                              text = 'Wed';
                              break;
                            case 4:
                              text = 'Thu';
                              break;
                            case 5:
                              text = 'Fri';
                              break;
                            case 6:
                              text = 'Sat';
                              break;
                            case 7:
                              text = 'Sun';
                              break;
                            default:
                              text = '';
                              break;
                          }
                          // The SideTitleWidget MUST be used here.
                          // It requires the 'axisSide' from the 'meta' object to render correctly.
                          return SideTitleWidget(
                            meta: meta,
                            space: 4.0, // Space between the chart and the title
                            child: Text(text, style: style),
                          );
                        },
                      ),
                    ),
                    // Hide left titles (Y-axis) for a minimal look
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenseViewModel.expenses.length,
              itemBuilder: (context, index) {
                final expense = expenseViewModel.expenses[index];
                return ListTile(
                  title: Text('\$${expense.amount.toStringAsFixed(2)}'),
                  subtitle: Text(DateFormat.yMMMd().format(expense.date)),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddExpenseDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    final TextEditingController amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Expense'),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final amount = double.tryParse(amountController.text);
                if (amount != null) {
                  Provider.of<ExpenseViewModel>(
                    context,
                    listen: false,
                  ).addExpense(amount);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
