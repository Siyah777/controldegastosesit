import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  // Eliminamos el parámetro 'key' en el constructor
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gastos Personales',
      
      theme: ThemeData(
  primaryColor: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.grey[200],
  textTheme: TextTheme(
    headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    bodyText2: TextStyle(fontSize: 16),
  ),
),
      ),
      home: HomePage(),
    );
  }
}

import 'package:google_fonts/google_fonts.dart';

Text(
  'Saldo total',
  style: GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold),
),


