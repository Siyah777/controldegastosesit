import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/db_helper.dart';
import 'add_edit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState(); 
}

class HomePageState extends State<HomePage> {
  
  List<Map<String, dynamic>> _transactions = [];
  double _total = 0;

  void _refreshTransactions() async {
    final data = await DatabaseHelper.instance.getTransactions();
    double total = 0;
    for (var t in data) {
      total += t['amount'];
    }
    setState(() {
      _transactions = data;
      _total = total;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshTransactions();
  }

  void _deleteTransaction(int id) async {
    await DatabaseHelper.instance.deleteTransaction(id);
    _refreshTransactions();
  }

  void _showDeleteDialog(int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Eliminar gasto?'),
        content: const Text('Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _deleteTransaction(id);
            },
            child: const Text(
              'Eliminar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToAddEdit([Map<String, dynamic>? transaction]) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => AddEditTransactionPage(transaction: transaction),
    ));
    _refreshTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Gastos'),
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/gastos.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Contenido encima de la imagen
          Column(
            children: [
              // Mensaje de bienvenida
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                color: Colors.greenAccent.shade100,
                child: const Text(
                  'Bienvenido a tu panel de gastos',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              // Gastos totales debajo del mensaje
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                width: double.infinity,
                color: Colors.greenAccent.shade100,
                child: Text(
                  'Gastos Totales: \$${_total.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),

              // Lista de transacciones
                 Expanded(
                child: ListView.builder(
                  itemCount: _transactions.length,
                  itemBuilder: (ctx, i) {
                    final t = _transactions[i];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: ListTile(
                        title: Text(
                          t['description'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${t['category']} - ${DateFormat.yMd().format(DateTime.parse(t['date']))}",
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Monto: \$${t['amount'].toStringAsFixed(2)}",
                              style: const TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _navigateToAddEdit(t),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _showDeleteDialog(t['id']),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Parte inferior
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                color: Colors.greenAccent.shade200,
                child: const Text(
                  '© 2025 Control de Gastos app ESIT Grupo 11, Todos los derechos reservados',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Padding(
  padding: const EdgeInsets.only(bottom: 60), // Ajusta para no tapar el footer
  child: FloatingActionButton(
    onPressed: () => _navigateToAddEdit(),
    backgroundColor: Colors.greenAccent,        // Color del botón
    foregroundColor: Colors.white,       // Color del ícono
    elevation: 6,                        // Sombra
    shape: RoundedRectangleBorder(      // Estilo redondeado
      borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add),        // Ícono
      ),
    ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,


    );
  }
}
