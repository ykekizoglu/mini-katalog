import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog/models/product.dart';
import 'package:mini_katalog/screens/catalog_screen.dart';

void main() {
  testWidgets('Bağlantı hatasından sonra yeniden deneme ürünleri yükler', (
    tester,
  ) async {
    var attempts = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: CatalogScreen(
          showBanner: false,
          loadProducts: () async {
            if (++attempts == 1) throw Exception('Bağlantı yok');
            return [
              const Product(
                id: 1,
                name: 'Deneme ürünü',
                description: 'Ürün',
                category: 'Teknoloji',
                image: 'assets/images/product_1.png',
                price: 10,
              ),
            ];
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Yeniden dene'), findsOneWidget);
    await tester.tap(find.text('Yeniden dene'));
    await tester.pumpAndSettle();
    expect(find.text('Deneme ürünü'), findsOneWidget);
    expect(attempts, 2);
  });
}
