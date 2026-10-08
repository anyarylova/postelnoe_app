import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'order_provider.dart';

class CartNotifier extends StateNotifier<List<OrderState>> {
  CartNotifier() : super([]);

  void addItem(OrderState item) {
    state = [...state, item];
  }

  void removeItem(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }

  void clearCart() {
    state = [];
  }

  int get totalCartPrice => state.fold(0, (sum, item) => sum + item.totalPrice);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<OrderState>>((ref) {
  return CartNotifier();
});