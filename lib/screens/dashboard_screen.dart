import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/card_item.dart';
import '../widgets/action_button.dart';
import '../widgets/transaction_item.dart';
import '../widgets/chart_section.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Row(
        children: [

          // SIDEBAR
          const Sidebar(),

          // CONTENIDO
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [

                  // IZQUIERDA
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text("Cards",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

                        const SizedBox(height: 20),

                        const CardItem(title: "Citibank Plus", balance: "\$2 505"),
                        const CardItem(title: "Mom’s card", balance: "\$3 125"),
                        const CardItem(title: "Citibank Visa", balance: "\$1 453"),

                        const SizedBox(height: 20),

                        const Text("Trasactions",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                        const TransactionItem(title: "Amazon", amount: "\$253"),
                        const TransactionItem(title: "Walmart", amount: "\$79"),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20),

                  // DERECHA
                  Expanded(
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            ActionButton(icon: Icons.add, label: "Replenish"),
                            ActionButton(icon: Icons.payment, label: "Pay"),
                            ActionButton(icon: Icons.list, label: "Requisites"),
                            ActionButton(icon: Icons.star, label: "Favorites"),
                          ],
                        ),

                        const SizedBox(height: 20),

                        const ChartSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}