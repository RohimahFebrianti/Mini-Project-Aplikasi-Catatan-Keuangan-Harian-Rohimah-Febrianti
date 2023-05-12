import 'package:apk_catatan_keuangan_harian/view/catatan/caku_screen.dart';
import 'package:apk_catatan_keuangan_harian/view_model/category_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('Form Catatan', () {
    testWidgets('Test form pengeluaran', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CategoryManager(),
          child: const MaterialApp(
            home: FormCaku(isExpense: true),
          ),
        ),
      );
      expect(find.text('Form Pengeluaran'), findsOneWidget);
    });

    testWidgets('Test form pemasukan', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CategoryManager(),
          child: const MaterialApp(
            home: FormCaku(isExpense: false),
          ),
        ),
      );
      expect(find.text('Form Pemasukan'), findsOneWidget);
    });

    testWidgets('Test text form field', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CategoryManager(),
          child: const MaterialApp(
            home: FormCaku(isExpense: false),
          ),
        ),
      );

      Finder inputField = find.byType(TextFormField);
      expect(inputField, findsNWidgets(3));
    });

    testWidgets('Test button save', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CategoryManager(),
          child: const MaterialApp(
            home: FormCaku(isExpense: false),
          ),
        ),
      );

      Finder saveButton = find.byType(ElevatedButton);
      expect(saveButton, findsOneWidget);
    });

    testWidgets('Test button kategori', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CategoryManager(),
          child: const MaterialApp(
            home: FormCaku(isExpense: false),
          ),
        ),
      );

      expect(find.text('Tambah Kategori Pemasukan'), findsOneWidget);
    });
  });
}
