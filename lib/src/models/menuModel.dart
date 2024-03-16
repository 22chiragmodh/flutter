class MenuItem {
  final String name;
  final String restaurant;
  final double price;
  final bool isAvailable;
  final String category;
  final bool isVeg;
  final String photo;
  final String id;

  MenuItem(
      {required this.name,
      required this.restaurant,
      required this.price,
      required this.isAvailable,
      required this.category,
      required this.isVeg,
      required this.photo,
      required this.id});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'],
      id: json['_id'],
      restaurant: json['restaurant'],
      price: json['price'].toDouble(),
      isAvailable: json['isAvailable'],
      category: json['category'],
      isVeg: json['isVeg'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'restaurant': restaurant,
      'price': price,
      'isAvailable': isAvailable,
      'category': category,
      'isVeg': isVeg,
      'photo': photo,
    };
  }
}
