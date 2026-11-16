import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductImage extends StatelessWidget {
  final Product product;
  const ProductImage({super.key, required this.product});

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: product.image.startsWith('https://')
        ? Image.network(
            product.image,
            fit: BoxFit.contain,
            errorBuilder: (_, error, stack) =>
                const Center(child: Icon(Icons.image_not_supported_outlined)),
            loadingBuilder: (_, child, progress) => progress == null
                ? child
                : const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
          )
        : Image.asset(product.image, fit: BoxFit.cover),
  );
}
