class Product {
  final int id;
  final String name, description, category, image;
  final double price;
  final String currency;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
    this.currency = 'USD',
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    category: (json['category'] ?? 'Teknoloji') as String,
    image: json['image'] as String,
    price: json['price'] is num
        ? (json['price'] as num).toDouble()
        : double.parse(
            (json['price'] as String).replaceAll(RegExp(r'[^0-9.]'), ''),
          ),
    currency: (json['currency'] ?? 'USD') as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'category': category,
    'image': image,
    'price': price,
    'currency': currency,
  };

  String get formattedPrice => '${price.toStringAsFixed(2)} $currency';
}
