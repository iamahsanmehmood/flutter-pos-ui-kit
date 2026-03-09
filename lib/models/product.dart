/// Product model for POS system
class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final int stock;
  final bool isAvailable;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.imageUrl = '',
    this.stock = 0,
    this.isAvailable = true,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as String,
        name: json['name'] as String,
        category: json['category'] as String,
        price: (json['price'] as num).toDouble(),
        imageUrl: json['imageUrl'] as String? ?? '',
        stock: json['stock'] as int? ?? 0,
        isAvailable: json['isAvailable'] as bool? ?? true,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'price': price,
        'imageUrl': imageUrl,
        'stock': stock,
        'isAvailable': isAvailable,
      };
}

/// Cart item — wraps a product with quantity
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get total => product.price * quantity;

  void increment() => quantity++;
  void decrement() {
    if (quantity > 1) quantity--;
  }
}

/// Order model
class Order {
  final String id;
  final List<CartItem> items;
  final double subtotal;
  final double tax;
  final double discount;
  final double total;
  final String paymentMethod;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.discount,
    required this.total,
    required this.paymentMethod,
    required this.createdAt,
  });

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
}

/// Sample product data
class SampleData {
  static final products = [
    const Product(id: '1', name: 'Chicken Biryani', category: 'Rice', price: 350, stock: 50),
    const Product(id: '2', name: 'Beef Karahi', category: 'Curry', price: 800, stock: 30),
    const Product(id: '3', name: 'Naan', category: 'Bread', price: 40, stock: 100),
    const Product(id: '4', name: 'Pepsi 1.5L', category: 'Drinks', price: 180, stock: 80),
    const Product(id: '5', name: 'Chicken Tikka', category: 'BBQ', price: 600, stock: 25),
    const Product(id: '6', name: 'Dal Makhni', category: 'Curry', price: 280, stock: 40),
    const Product(id: '7', name: 'Seekh Kebab', category: 'BBQ', price: 500, stock: 35),
    const Product(id: '8', name: 'Raita', category: 'Sides', price: 80, stock: 60),
    const Product(id: '9', name: 'Gulab Jamun', category: 'Dessert', price: 150, stock: 45),
    const Product(id: '10', name: 'Mineral Water', category: 'Drinks', price: 60, stock: 200),
    const Product(id: '11', name: 'Pulao', category: 'Rice', price: 300, stock: 30),
    const Product(id: '12', name: 'Halwa Puri', category: 'Breakfast', price: 250, stock: 20),
  ];

  static final categories = ['All', 'Rice', 'Curry', 'BBQ', 'Bread', 'Drinks', 'Sides', 'Dessert', 'Breakfast'];
}
