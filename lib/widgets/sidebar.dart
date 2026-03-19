import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: const Color(0xFF2C2C54),
      child: Column(
        children: const [
          SizedBox(height: 60),
          CircleAvatar(radius: 40),
          SizedBox(height: 10),
          Text("Stephanie Jones", style: TextStyle(color: Colors.white)),
          SizedBox(height: 30),

          ListTile(title: Text("Accounts", style: TextStyle(color: Colors.white))),
          ListTile(title: Text("Transactions", style: TextStyle(color: Colors.white))),
          ListTile(title: Text("Bonus", style: TextStyle(color: Colors.white))),
          ListTile(title: Text("Investments", style: TextStyle(color: Colors.white))),
          ListTile(title: Text("Settings", style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}