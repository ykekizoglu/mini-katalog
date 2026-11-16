import 'dart:convert';
import '../models/product.dart';
import 'fetch.dart';

class ProductService {
  static const productsUrl = 'https://wantapi.com/products.php';
  static const bannerUrl = 'https://wantapi.com/assets/banner.png';

  static Future<List<Product>> loadProducts() async {
    final json =
        jsonDecode(await fetchText(Uri.parse(productsUrl)))
            as Map<String, dynamic>;
    if (json['status'] != 'success') {
      throw const FormatException('Geçersiz yanıt');
    }
    return (json['data'] as List)
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
