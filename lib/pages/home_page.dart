import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/db_helper.dart';
import 'add_edit_page.dart';
import '../widgets/balance_summary.dart';
import '../widgets/transaction_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transacciones'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BalanceSummary(),
          Expanded(child: TransactionList()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Colors.white,
  selectedItemColor: Colors.deepPurple,
  unselectedItemColor: Colors.grey,
),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Transacciones'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Informes'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categorías'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add, size: 30),
),
      ),
    );
  }
}

class HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _transactions = [];
  double _total = 0;

  // Refresca las transacciones y calcula el total
  void _refreshTransactions() async {
    final data = await DatabaseHelper.instance.getTransactions();
    double total = 0;
    // Usamos un bucle for en lugar de forEach
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

  // Elimina una transacción por su id
  void _deleteTransaction(int id) async {
    await DatabaseHelper.instance.deleteTransaction(id);
    _refreshTransactions();
  }

  // Muestra un diálogo de confirmación antes de eliminar
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

  // Navega a la página de agregar o editar transacción
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
        title: Text('Gastos Totales: \$${_total.toStringAsFixed(2)}'),
      ),
      body: ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (ctx, i) {
          final t = _transactions[i];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              title: Text(t['description']),
              subtitle: Text(
                  "${t['category']} - ${DateFormat.yMd().format(DateTime.parse(t['date']))}"),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddEdit(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
