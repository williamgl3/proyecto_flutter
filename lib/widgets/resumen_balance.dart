import 'package:flutter/material.dart';

class ResumenBalance extends StatelessWidget {
  final double balance;
  final double gastos;
  final double ingresos;
  final double mes;

  const ResumenBalance({
    super.key,
    required this.balance,
    required this.gastos,
    required this.ingresos,
    required this.mes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem('Balance', '\$${balance.toStringAsFixed(0)}', Colors.blue),
          _buildItem('Gastos', '\$${gastos.toStringAsFixed(0)}', Colors.red),
          _buildItem('Ingresos', '\$${ingresos.toStringAsFixed(0)}', Colors.green),
          _buildItem('Noviembre', '\$${mes.toStringAsFixed(0)}', Colors.orange),
        ],
      ),
    );
  }

  Widget _buildItem(String label, String valor, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.attach_money,
            color: color,
            size: 18,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 2),
        Text(
          valor,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}