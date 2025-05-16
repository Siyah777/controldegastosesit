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
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.greenAccent[200],
  textTheme: TextTheme(
    titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 20),
  ),
),
      //),
home: HomePage(),
);
  }
}






