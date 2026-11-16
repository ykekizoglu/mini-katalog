import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_image.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(title: const Text('Ürün detayı')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              AspectRatio(
                aspectRatio: 1.2,
                child: ProductImage(product: product),
              ),
              const SizedBox(height: 24),
              Text(
                product.category,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 8),
              Text(
                product.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                product.formattedPrice,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              Text(
                product.description,
                style: const TextStyle(fontSize: 16, height: 1.6),
              ),
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: () => Navigator.pop(context, product),
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Sepete ekle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
