class OrderItem {
  final String name;
  final double price;
  final bool isVeg;
  final int quantity;
  final String menuItemRef;
  final String id;

  OrderItem({
    required this.name,
    required this.price,
    required this.isVeg,
    required this.quantity,
    required this.menuItemRef,
    required this.id,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      isVeg: json['isVeg'] ?? false,
      quantity: json['quantity'] ?? 0,
      menuItemRef: json['menuItemRef'] ?? '',
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'isVeg': isVeg,
      'quantity': quantity,
      'menuItemRef': menuItemRef,
      '_id': id,
    };
  }
}
