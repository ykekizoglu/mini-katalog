import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog/models/product.dart';

void main() {
  test('WantAPI dolar fiyatını, görselini ve varsayılan kategoriyi okur', () {
    final product = Product.fromJson({
      'id': 1,
      'name': 'MacBook Pro',
      'description': 'Demo',
      'price': '\$1,599',
      'currency': 'USD',
      'image': 'https://wantapi.com/assets/images/macbook.png',
    });
    expect(product.price, 1599);
    expect(product.formattedPrice, '1599.00 USD');
    expect(product.category, 'Teknoloji');
    expect(Product.fromJson(product.toJson()).price, 1599);
  });
}
