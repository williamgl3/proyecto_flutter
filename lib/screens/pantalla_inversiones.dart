import 'package:flutter/material.dart';

class PantallaInversiones extends StatelessWidget {
  const PantallaInversiones({super.key});

  @override
  Widget build(BuildContext context) {
    final inversiones = [
      ('Fondo Conservador', 12500.00),
      ('CETES 28 dias', 8300.00),
      ('Plazo fijo', 15000.00),
    ];

    final total = inversiones.fold<double>(
      0,
      (acumulado, item) => acumulado + item.$2,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Inversiones',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.account_balance, color: Colors.green),
              title: const Text('Total invertido'),
              subtitle: Text('MXN ${total.toStringAsFixed(2)}'),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Portafolio',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          ...inversiones.map(
            (item) => Card(
              child: ListTile(
                leading: const Icon(Icons.trending_up),
                title: Text(item.$1),
                trailing: Text('MXN ${item.$2.toStringAsFixed(2)}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
