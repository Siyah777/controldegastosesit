// transaction_list.dart
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;
  final Function(int) onDelete;

  const TransactionList({super.key, required this.transactions, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final t = transactions[index];
        return Card(
          child: ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text(t['description']),
            subtitle: Text(t['category']),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => onDelete(t['id']),
            ),
          ),
        );
      },
    );
  }
}
