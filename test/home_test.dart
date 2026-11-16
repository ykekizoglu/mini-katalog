import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog/screens/home_screen.dart';

void main() {
  testWidgets('Ana sayfa katalog rotasını açar ve geri dönülür', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const HomeScreen(),
        routes: {
          '/catalog': (_) =>
              Scaffold(appBar: AppBar(title: const Text('Ürün listesi'))),
        },
      ),
    );
    await tester.tap(find.text('Ürünlere göz at'));
    await tester.pumpAndSettle();
    expect(find.text('Ürün listesi'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Mini Katalog’a hoş geldin'), findsOneWidget);
  });
}
