import 'package:apk_catatan_keuangan_harian/view/history/history_screen.dart';
import 'package:apk_catatan_keuangan_harian/view_model/caku_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('History', () {
    testWidgets('Test text pada History', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CakuManager(),
          child: const MaterialApp(
            home: HistoryPage(),
          ),
        ),
      );
      expect(find.text('History'), findsOneWidget);
    });

    testWidgets('Test List History', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CakuManager(),
          child: const MaterialApp(
            home: HistoryPage(),
          ),
        ),
      );

      Finder listView = find.byType(Consumer<CakuManager>);
      expect(listView, findsOneWidget);
    });
    
    testWidgets('Test button filter', (WidgetTester tester) async {
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
