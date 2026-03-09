import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/cart_sidebar.dart';
import '../widgets/category_chips.dart';

/// Main POS screen with product grid and cart sidebar
class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  final List<CartItem> _cart = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';

  List<Product> get _filteredProducts {
    return SampleData.products.where((p) {
      final matchesCategory = _selectedCategory == 'All' || p.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty || 
          p.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  double get _subtotal => _cart.fold(0, (sum, item) => sum + item.total);
  double get _tax => _subtotal * 0.17;
  double get _total => _subtotal + _tax;

  void _addToCart(Product product) {
    setState(() {
      final existingIndex = _cart.indexWhere((item) => item.product.id == product.id);
      if (existingIndex >= 0) {
        _cart[existingIndex].increment();
      } else {
        _cart.add(CartItem(product: product));
      }
    });
  }

  void _removeFromCart(int index) {
    setState(() => _cart.removeAt(index));
  }

  void _updateQuantity(int index, int delta) {
    setState(() {
      if (delta > 0) {
        _cart[index].increment();
      } else if (_cart[index].quantity > 1) {
        _cart[index].decrement();
      } else {
        _cart.removeAt(index);
      }
    });
  }

  void _clearCart() {
    setState(() => _cart.clear());
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.point_of_sale, color: colorScheme.primary),
            const SizedBox(width: 8),
            const Text('Flutter POS', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {}),
          const SizedBox(width: 8),
        ],
      ),
      body: Row(
        children: [
          // Product Grid (left side - 65%)
          Expanded(
            flex: 65,
            child: Column(
              children: [
                // Search bar
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    onChanged: (value) => setState(() => _searchQuery = value),
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                // Category chips
                CategoryChips(
                  categories: SampleData.categories,
                  selected: _selectedCategory,
                  onSelected: (cat) => setState(() => _selectedCategory = cat),
                ),

                // Product grid
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) => ProductCard(
                      product: _filteredProducts[index],
                      onTap: () => _addToCart(_filteredProducts[index]),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Cart sidebar (right side - 35%)
          Expanded(
            flex: 35,
            child: CartSidebar(
              items: _cart,
              subtotal: _subtotal,
              tax: _tax,
              total: _total,
              onRemove: _removeFromCart,
              onUpdateQuantity: _updateQuantity,
              onClear: _clearCart,
              onCheckout: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Checkout: PKR ${_total.toStringAsFixed(0)}')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
