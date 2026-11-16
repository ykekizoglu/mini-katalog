import 'package:flutter/material.dart';
import 'screens/catalog_screen.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'models/product.dart';

void main() => runApp(const MiniKatalogApp());

class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Mini Katalog',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF386A56)),
      scaffoldBackgroundColor: const Color(0xFFFAFAF7),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFAFAF7)),
      useMaterial3: true,
    ),
    onGenerateRoute: (settings) => settings.name == '/product'
        ? MaterialPageRoute<Product>(
            settings: settings,
            builder: (_) => const DetailScreen(),
          )
        : null,
    initialRoute: '/',
    routes: {
      '/': (_) => const HomeScreen(),
      '/catalog': (_) => const CatalogScreen(),
    },
  );
}
