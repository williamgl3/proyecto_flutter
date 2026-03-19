import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final String amount;

  const TransactionItem({super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.shopping_cart),
      title: Text(title),
      trailing: Text(amount),
    );
  }
}