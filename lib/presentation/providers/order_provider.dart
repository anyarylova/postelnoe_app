import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/fabric.dart';
import '../../domain/entities/bedding_set_type.dart';
import '../../domain/entities/product_item.dart';
import '../../data/datasources/mock_data.dart'; // тестовые данные
import '../../domain/services/price_calculator.dart';

// STATE
class OrderState {
  final Fabric selectedFabric;
  final BeddingSet currentSet; // Тип + Список предметов
  final int totalPrice;

  OrderState({
    required this.selectedFabric,
    required this.currentSet,
    required this.totalPrice,
  });

  OrderState copyWith({
    Fabric? selectedFabric,
    BeddingSet? currentSet,
    int? totalPrice,
  }) {
    return OrderState(
      selectedFabric: selectedFabric ?? this.selectedFabric,
      currentSet: currentSet ?? this.currentSet,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}

// NOTIFIER
class OrderNotifier extends StateNotifier<OrderState> {
  final PriceCalculator _calculator = PriceCalculator();

  // НАЧАЛЬНОЕ состояние
  OrderNotifier() : super(_initialState());

  static OrderState _initialState() {
    final defaultFabric = mockFabrics[0]; // Берем первую ткань из списка
    final defaultSet = BeddingSet.fromType(BeddingSetType.singleAndHalf); // 1.5-спальное по дефолту
    
    final calculator = PriceCalculator();
    final price = calculator.calculatePrice(fabric: defaultFabric, set: defaultSet);

    return OrderState(
      selectedFabric: defaultFabric,
      currentSet: defaultSet,
      totalPrice: price,
    );
  }

  void selectFabric(Fabric newFabric) {
    final newPrice = _calculator.calculatePrice(
      fabric: newFabric, 
      set: state.currentSet
    );

    state = state.copyWith(
      selectedFabric: newFabric,
      totalPrice: newPrice,
    );
  }

  void selectType(BeddingSetType newType) {
    final newSet = BeddingSet.fromType(newType);

    final newPrice = _calculator.calculatePrice(
      fabric: state.selectedFabric,
      set: newSet
    );

    state = state.copyWith(
      currentSet: newSet,
      totalPrice: newPrice,
    );
  }


  void toggleElastic(bool isElastic) {
    final newSet = BeddingSet.fromType(
      state.currentSet.type, 
      isElastic: isElastic
    );

    final newPrice = _calculator.calculatePrice(
      fabric: state.selectedFabric,
      set: newSet
    );

    state = state.copyWith(
      currentSet: newSet,
      totalPrice: newPrice,
    );
  }
}

// PROVIDER
final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  return OrderNotifier();
});