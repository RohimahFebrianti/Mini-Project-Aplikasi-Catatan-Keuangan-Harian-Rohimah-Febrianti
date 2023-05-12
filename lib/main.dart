import 'package:apk_catatan_keuangan_harian/view/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_model/caku_manager.dart';
import 'view_model/category_manager.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => CakuManager(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
      },
    );
  }
}
