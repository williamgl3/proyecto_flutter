import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String title;
  final String balance;

  const CardItem({super.key, required this.title, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.credit_card),
        title: Text(title),
        subtitle: const Text("Balance"),
        trailing: Text(balance, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}