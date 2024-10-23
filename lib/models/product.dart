class Product {
  final int id;
  final String name;
  final String description;
  final String price;
  final String image;
  final String createdAt;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.createdAt,
    this.quantity = 1,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image']??"",
      createdAt: json['created_at'],
      quantity: json['quantity'] ?? 1,
    );
  }
}
