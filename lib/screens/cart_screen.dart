import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_image.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cart;
  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final total = widget.cart.fold<double>(0, (sum, item) => sum + item.price);
    return Scaffold(
      appBar: AppBar(title: const Text('Sepetim')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: widget.cart.isEmpty
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text('Sepetin henüz boş', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 8),
                    Text('Katalogdan beğendiğin ürünleri ekleyebilirsin.'),
                  ],
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: widget.cart.length,
                        separatorBuilder: (_, _) => const Divider(height: 24),
                        itemBuilder: (context, index) {
                          final product = widget.cart[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: SizedBox(
                              width: 64,
                              height: 64,
                              child: ProductImage(product: product),
                            ),
                            title: Text(product.name),
                            subtitle: Text(product.formattedPrice),
                            trailing: IconButton(
                              tooltip: 'Sepetten çıkar',
                              onPressed: () =>
                                  setState(() => widget.cart.removeAt(index)),
                              icon: const Icon(Icons.delete_outline),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Toplam', style: TextStyle(fontSize: 20)),
                          Text(
                            '${total.toStringAsFixed(2)} USD',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 24),
                      child: Text(
                        'Eğitim projesi • Sepet bilgisi uygulama kapanınca silinir.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
