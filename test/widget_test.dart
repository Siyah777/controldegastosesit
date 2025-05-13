// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:gastos_app/main.dart'; // Asegúrate de que este import apunta al archivo correcto

void main() {
  testWidgets('Carga de la app y muestra de título', (WidgetTester tester) async {
    // Construye la app y espera a que se dibuje
    await tester.pumpWidget(const ExpenseApp());

    // Verifica que se muestra el texto del AppBar
    expect(find.textContaining('Gastos Totales'), findsOneWidget);
  });
}
