import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/db_helper.dart';

class AddEditTransactionPage extends StatefulWidget {
  final Map<String, dynamic>? transaction;

  // Corregir el paso del parámetro 'key' correctamente al constructor de StatefulWidget
  const AddEditTransactionPage({super.key, this.transaction});

  @override
  AddEditTransactionPageState createState() => AddEditTransactionPageState();
}

class AddEditTransactionPageState extends State<AddEditTransactionPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String selectedCategory = 'General';
  DateTime selectedDate = DateTime.now();

  final List<String> categories = [
    'General',
    'Alimentos',
    'Transporte',
    'Salud',
    'Entretenimiento'
  ];

  @override
  void initState() {
    super.initState();
    final t = widget.transaction;
    if (t != null) {
      descriptionController.text = t['description'];
      amountController.text = t['amount'].toString();
      selectedCategory = t['category'];
      selectedDate = DateTime.parse(t['date']);
    }
  }

  @override
  void dispose() {
    descriptionController.dispose();
    amountController.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    final navigator = Navigator.of(context);
    final row = {
      'description': descriptionController.text,
      'amount': double.parse(amountController.text),
      'category': selectedCategory,
      'date': selectedDate.toIso8601String(),
    };

    if (widget.transaction == null) {
      await DatabaseHelper.instance.insertTransaction(row);
    } else {
      row['id'] = widget.transaction!['id'];
      await DatabaseHelper.instance.updateTransaction(row);
    }

    if (!mounted) return;
    navigator.pop();
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate && mounted) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Gasto' : 'Nuevo Gasto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: amountController,
                decoration: const InputDecoration(labelText: 'Monto'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Campo requerido';
                  if (double.tryParse(v) == null) return 'Número inválido';
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => selectedCategory = v!),
                decoration: const InputDecoration(labelText: 'Categoría'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text('Fecha: ${DateFormat.yMd().format(selectedDate)}'),
                  ),
                  TextButton(
                    onPressed: pickDate,
                    child: const Text('Seleccionar Fecha'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: submitForm,
                child: Text(isEditing ? 'Guardar Cambios' : 'Agregar Gasto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}