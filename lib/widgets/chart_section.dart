import 'package:flutter/material.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 250,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.pie_chart, size: 80, color: Colors.blue),
              SizedBox(height: 10),
              Text("\$343", style: TextStyle(fontSize: 24)),
              Text("Restaurants"),
            ],
          ),
        ),
      ),
    );
  }
}