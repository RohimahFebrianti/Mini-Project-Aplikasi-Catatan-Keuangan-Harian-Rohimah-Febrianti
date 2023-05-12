import 'package:apk_catatan_keuangan_harian/view/history/history_screen.dart';
import 'package:apk_catatan_keuangan_harian/view/kategori/category_screen.dart';
import 'package:apk_catatan_keuangan_harian/view_model/caku_manager.dart';
import 'package:apk_catatan_keuangan_harian/view_model/category_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('Kategori', () {
    testWidgets('Test text pada Kategori', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CategoryManager(),
          child: const MaterialApp(
            home: CategoryPage(isExpense: true),
          ),
        ),
      );
      expect(find.text('List Pengeluaran'), findsOneWidget);
    });

    testWidgets('Test List', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CategoryManager(),
          child: const MaterialApp(
            home: CategoryPage(isExpense: true),
          ),
        ),
      );

      Finder listView = find.byType(Consumer<CategoryManager>);
      expect(listView, findsOneWidget);
    });

    testWidgets('Test icon add', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CakuManager(),
          child: const MaterialApp(
            home: HistoryPage(),
          ),
        ),
      );

      Finder filterButton = find.byType(IconButton);
      expect(filterButton, findsOneWidget);
    });
  });
}
