// balance_summary.dart
import 'package:flutter/material.dart';
class BalanceSummary extends StatelessWidget {
  final double total;
  final double ingresos;
  final double gastos;

  const BalanceSummary({
    super.key,
    required this.total,
    required this.ingresos,
    required this.gastos,
  });

  @override
  Widget build(BuildContext context) {
    // Usar los valores para mostrar el balance real
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Saldo total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('\$${total.toStringAsFixed(2)}', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat(Icons.arrow_upward, 'Ingresos', '\$${ingresos.toStringAsFixed(2)}'),
              _buildStat(Icons.arrow_downward, 'Gastos', '\$${gastos.toStringAsFixed(2)}'),
              _buildStat(Icons.balance, 'Balance', '\$${total.toStringAsFixed(2)}'),
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
