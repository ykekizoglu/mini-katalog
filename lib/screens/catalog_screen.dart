import 'package:flutter/material.dart';
import '../services/product_service.dart';
import '../models/product.dart';
import '../widgets/product_image.dart';
import 'cart_screen.dart';

class CatalogScreen extends StatefulWidget {
  final Future<List<Product>> Function()? loadProducts;
  final bool showBanner;
  const CatalogScreen({super.key, this.loadProducts, this.showBanner = true});
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final List<Product> _cart = [];
  late Future<List<Product>> _products =
      (widget.loadProducts ?? ProductService.loadProducts)();
  String _query = '';

  String _normalize(String value) =>
      value.replaceAll('İ', 'i').replaceAll('I', 'ı').toLowerCase();

  Future<void> _openProduct(Product product) async {
    final added = await Navigator.pushNamed<Product>(
      context,
      '/product',
      arguments: product,
    );
    if (!mounted || added == null) return;
    setState(() => _cart.add(added));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${added.name} sepete eklendi'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Mini Katalog'),
      actions: [
        TextButton.icon(
          onPressed: () async {
            await Navigator.push<void>(
              context,
              MaterialPageRoute(builder: (_) => CartScreen(cart: _cart)),
            );
            if (mounted) setState(() {});
          },
          icon: const Icon(Icons.shopping_bag_outlined),
          label: Text('Sepet (${_cart.length})'),
        ),
        const SizedBox(width: 8),
      ],
    ),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ürünleri keşfet',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Teknoloji ürünlerine göz at.',
                    style: TextStyle(color: Colors.black54),
                  ),
                  if (widget.showBanner) ...[
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        ProductService.bannerUrl,
                        height: 85,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, error, stack) =>
                            const SizedBox.shrink(),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (value) => setState(() => _query = value),
                    decoration: InputDecoration(
                      hintText: 'Ürün veya kategori ara',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: _products,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Ürünler yüklenemedi. İnternet bağlantını kontrol et.',
                          ),
                          const SizedBox(height: 12),
                          FilledButton(
                            onPressed: () => setState(() {
                              _products =
                                  (widget.loadProducts ??
                                  ProductService.loadProducts)();
                            }),
                            child: const Text('Yeniden dene'),
                          ),
                        ],
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final products = snapshot.data!
                      .where(
                        (p) => _normalize(
                          '${p.name} ${p.category}',
                        ).contains(_normalize(_query.trim())),
                      )
                      .toList();
                  if (products.isEmpty) {
                    return const Center(
                      child: Text('Aramana uygun ürün bulunamadı.'),
                    );
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 280,
                          mainAxisExtent: 270,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Card(
                        color: Colors.white,
                        elevation: 0,
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => _openProduct(product),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ProductImage(product: product),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  product.category,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product.formattedPrice,
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
