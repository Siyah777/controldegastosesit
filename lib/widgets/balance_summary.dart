import 'package:flutter/material.dart';

class BalanceSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Saldo total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('0.00\$', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat(Icons.arrow_upward, 'Ingresos', '0.00\$'),
              _buildStat(Icons.arrow_downward, 'Gastos', '0.00\$'),
              _buildStat(Icons.balance, 'Balance', '0.00\$'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 30),
        Text(label),
        Text(value),
      ],
    );
  }
}