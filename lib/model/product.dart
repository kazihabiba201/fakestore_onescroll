class Product {
  final int id;
  final String title;
  final String? image;
  final double price;
  final String category;

  Product({
    required this.id,
    required this.title,
    this.image,
    required this.price,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
    );
  }
}
