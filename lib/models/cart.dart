class CartItem {
  final int id;
  final int productId;
  final int quantity;
  final String createdAt;
  final String productName;
  final double price;
  final String image;

  CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.productName,
    required this.price,
    required this.image,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      createdAt: json['created_at'],
      productName: json['product_name'],
      price: double.parse(json['price'])*json['quantity'],
      image: json['image']??""
    );
  }
}
