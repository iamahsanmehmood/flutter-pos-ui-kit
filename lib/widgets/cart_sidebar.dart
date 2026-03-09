import 'package:flutter/material.dart';
import '../models/product.dart';

class CartSidebar extends StatelessWidget {
  final List<CartItem> items;
  final double subtotal;
  final double tax;
  final double total;
  final void Function(int) onRemove;
  final void Function(int, int) onUpdateQuantity;
  final VoidCallback onClear;
  final VoidCallback onCheckout;

  const CartSidebar({
    super.key,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.total,
    required this.onRemove,
    required this.onUpdateQuantity,
    required this.onClear,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.2),
        border: Border(left: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cart (${items.length})', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                if (items.isNotEmpty)
                  TextButton(onPressed: onClear, child: const Text('Clear')),
              ],
            ),
          ),
          const Divider(height: 1),

          // Cart items
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('Cart is empty', style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text(item.product.name, style: const TextStyle(fontSize: 13)),
                        subtitle: Text('PKR ${item.product.price.toStringAsFixed(0)} × ${item.quantity}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline, size: 20),
                              onPressed: () => onUpdateQuantity(index, -1),
                            ),
                            Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline, size: 20),
                              onPressed: () => onUpdateQuantity(index, 1),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // Totals
          if (items.isNotEmpty) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildRow('Subtotal', subtotal, colorScheme),
                  const SizedBox(height: 4),
                  _buildRow('Tax (17%)', tax, colorScheme),
                  const Divider(),
                  _buildRow('Total', total, colorScheme, bold: true, size: 18),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton.icon(
                      onPressed: onCheckout,
                      icon: const Icon(Icons.payment),
                      label: Text('Checkout — PKR ${total.toStringAsFixed(0)}'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRow(String label, double amount, ColorScheme cs, {bool bold = false, double size = 14}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, fontSize: size)),
        Text(
          'PKR ${amount.toStringAsFixed(0)}',
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontSize: size,
            color: bold ? cs.primary : null,
          ),
        ),
      ],
    );
  }
}
