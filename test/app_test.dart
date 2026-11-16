import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog/screens/catalog_screen.dart';
import 'package:mini_katalog/models/product.dart';
import 'package:mini_katalog/screens/detail_screen.dart';

void main() {
  testWidgets('Ürün arama, detay, sepete ekleme ve çıkarma', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        onGenerateRoute: (settings) => MaterialPageRoute<Product>(
          settings: settings,
          builder: (_) => const DetailScreen(),
        ),
        home: CatalogScreen(
          showBanner: false,
          loadProducts: () async => [
            const Product(
              id: 1,
              name: 'Bez Çanta',
              description: 'Çanta',
              category: 'Aksesuar',
              image: 'assets/images/product_1.png',
              price: 149,
            ),
            const Product(
              id: 2,
              name: 'Seramik Kupa',
              description: 'Kupa',
              category: 'Ev',
              image: 'assets/images/product_2.png',
              price: 189,
            ),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Bez Çanta'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'SERAMİK');
    await tester.pumpAndSettle();
    expect(find.text('Bez Çanta'), findsNothing);
    await tester.tap(find.text('Seramik Kupa'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Sepete ekle'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Sepete ekle'));
    await tester.pumpAndSettle();
    expect(find.text('Sepet (1)'), findsOneWidget);
    await tester.tap(find.text('Sepet (1)'));
    await tester.pumpAndSettle();
    expect(find.text('Toplam'), findsOneWidget);
    await tester.tap(find.byTooltip('Sepetten çıkar'));
    await tester.pumpAndSettle();
    expect(find.text('Sepetin henüz boş'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Sepet (0)'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'olmayan ürün');
    await tester.pumpAndSettle();
    expect(find.text('Aramana uygun ürün bulunamadı.'), findsOneWidget);
  });
}
