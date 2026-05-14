import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postelnoe_app/domain/entities/bedding_set_type.dart';
import '../../../domain/entities/product_item.dart';
import '../../providers/order_provider.dart';

class OrderScreen extends ConsumerWidget {
  // final ProductItem item;

  const OrderScreen({super.key, /*required this.item*/});

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
    final orderState = ref.watch(orderProvider);
    final fabric = orderState.selectedFabric;
    final isElastic = orderState.currentSet.items.any((element) => 
    element.type == ProductType.sheet && (element.elastic ?? false));

    return Scaffold(
      appBar: AppBar(title: const Text('Оформление заказа')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  fabric.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(height: 200, color: Colors.grey, child: Center(child: Icon(Icons.image),),)
                ),
              ),
              const SizedBox(height: 16),
              Text(
                fabric.patternName,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'Ткань: ${fabric.materialName}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.grey[700]),
              ),
              const Divider(height: 32),

              // конструктор комплекта
              const Text('Выберите размер комплекта:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              // список размеров
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<BeddingSetType>(
                    isExpanded: true,
                    value: orderState.currentSet.type,
                    items: BeddingSetType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(_getTypeName(type)),
                      );
                    }).toList(),
                    onChanged: (BeddingSetType? newType) {
                      if (newType != null) {
                        ref.read(orderProvider.notifier).selectType(newType);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              if (orderState.currentSet.type != BeddingSetType.custom) 
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Простыня на резинке (+500 Руб.)'),
                  value: isElastic,
                  onChanged: (bool? value) {
                    ref.read(orderProvider.notifier).toggleElastic(value ?? false);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              if (orderState.currentSet.type == BeddingSetType.custom) 
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Выбран индивидуальный пошив. Точная цена будет рассчитана после ввода ваших размеров.',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              
              const SizedBox(height: 40),

              // итоговая цена
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Итого:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${orderState.totalPrice} ₽',
                      style: const TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ) 
              ),
              
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Заказ формируется...')),
                    );
                  }, 
                  child: const Text('Оформить заказ', style: TextStyle(fontSize: 16)),),
              )
            ],
          )
        ),
      ),
    );
  }
}