import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/expense_viewmodel.dart';

/// Settings screen with additional features
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionCard(
            title: 'Data Management',
            children: [
              ListTile(
                leading: const Icon(Icons.download),
                title: const Text('Export Data'),
                subtitle: const Text('Export expenses to CSV'),
                onTap: () => _exportData(context),
              ),
              ListTile(
                leading: const Icon(Icons.delete_forever),
                title: const Text('Clear All Data'),
                subtitle: const Text('Remove all expenses permanently'),
                onTap: () => _clearAllData(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            title: 'Statistics',
            children: [
              Consumer<ExpenseViewModel>(
                builder: (context, viewModel, child) {
                  return Column(
                    children: [
                      _buildStatTile('Total Expenses', '\$${viewModel.totalAmount.toStringAsFixed(2)}', Icons.account_balance_wallet),
                      _buildStatTile('Expense Count', '${viewModel.expenses.length}', Icons.receipt),
                      _buildStatTile('Average Amount', '\$${viewModel.expenses.isEmpty ? "0.00" : (viewModel.totalAmount / viewModel.expenses.length).toStringAsFixed(2)}', Icons.trending_up),
                      _buildStatTile('This Month', '\$${viewModel.getTotalForMonth(DateTime.now()).toStringAsFixed(2)}', Icons.calendar_month),
                    ],
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            title: 'About',
            children: [
              const ListTile(
                leading: Icon(Icons.info),
                title: Text('Version'),
                subtitle: Text('1.0.0'),
              ),
              const ListTile(
                leading: Icon(Icons.code),
                title: Text('Built with Flutter'),
                subtitle: Text('MVVM Architecture'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildStatTile(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }

  void _exportData(BuildContext context) {
    final viewModel = context.read<ExpenseViewModel>();
    final csvData = viewModel.exportToCSV();
    
    if (csvData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No data to export'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // In a real app, you would save this to a file
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exported ${viewModel.expenses.length} expenses'),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'Copy',
          onPressed: () {
            // Copy to clipboard functionality would go here
          },
        ),
      ),
    );
  }

  void _clearAllData(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text('Are you sure you want to delete all expenses? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<ExpenseViewModel>().clearAllData();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All data cleared successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
