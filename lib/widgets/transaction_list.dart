import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: 4, // Reemplazar con datos dinámicos en el futuro
      itemBuilder: (context, index) {
List<Map<String, String>> transactions = [
          {'icon': 'shopping_cart', 'title': 'Compra en supermercado', 'amount': '-30.00\$'},
          {'icon': 'restaurant', 'title': 'Cena con amigos', 'amount': '-20.00\$'},
          {'icon': 'directions_car', 'title': 'Gasolina', 'amount': '-50.00\$'},
          {'icon': 'subscriptions', 'title': 'Suscripción mensual', 'amount': '-15.00\$'}, // Entrada 4
        ];

        return AnimatedContainer(
  duration: Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  child: Card(
    child: ListTile(
      leading: Icon(Icons.shopping_cart, color: Colors.blueAccent),
      title: Text('Compra #$index'),
      trailing: Text('-10.00\$', style: TextStyle(color: Colors.red)),
    ),
  ),
);

        return Card(
          child: ListTile(
            leading: Icon(_getIcon(transactions[index]['icon']!)),
            title: Text(transactions[index]['title']!),
            subtitle: Text('Detalle de la transacción'),
            trailing: Text(transactions[index]['amount']!, style: TextStyle(color: Colors.red)),
          ),
        );
      },
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'shopping_cart':
        return Icons.shopping_cart;
      case 'restaurant':
        return Icons.restaurant;
      case 'directions_car':
        return Icons.directions_car;
      case 'subscriptions':
        return Icons.subscriptions;
      default:
        return Icons.receipt;
    }
  }
}