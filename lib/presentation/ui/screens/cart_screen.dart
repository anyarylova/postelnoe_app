import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postelnoe_app/domain/entities/bedding_set_type.dart';
import '../../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  String _getTypeName(BeddingSetType type) {
    switch (type) {
      case BeddingSetType.singleAndHalf: return '1.5-спальное';
      case BeddingSetType.doubleStandard: return '2-спальное (стандарт)';
      case BeddingSetType.doubleEuroSheet: return '2-спальное (с европростыней)';
      case BeddingSetType.euro: return 'Евро';
      case BeddingSetType.family: return 'Семейный';
      case BeddingSetType.custom: return 'Свои размеры';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Корзина')),
      body: cartItems.isEmpty
          ? const Center(child: Text('Корзина пуста', style: TextStyle(fontSize: 18)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(item.selectedFabric.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                    ),
                    title: Text(item.selectedFabric.patternName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${_getTypeName(item.currentSet.type)}\n${item.totalPrice} ₽'),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => cartNotifier.removeItem(index),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cartItems.isEmpty ? null : SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Итого:', style: TextStyle(color: Colors.grey)),
                  Text('${cartNotifier.totalCartPrice} ₽', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  // TODO: куда-то собрать заказ (firebase/google sheets)
                },
                child: const Text('Оформить заказ', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}