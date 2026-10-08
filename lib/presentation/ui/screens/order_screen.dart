import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postelnoe_app/domain/entities/bedding_set_type.dart';
import '../../../domain/entities/product_item.dart';
import '../../providers/order_provider.dart';
import '../../providers/cart_provider.dart';

class OrderScreen extends ConsumerStatefulWidget {

  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  final _duvetWidthCtrl = TextEditingController(text: '145');
  final _duvetLengthCtrl = TextEditingController(text: '215');
  final _sheetWidthCtrl = TextEditingController(text: '150');
  final _sheetLengthCtrl = TextEditingController(text: '220');
  final _pillowWidthCtrl = TextEditingController(text: '70');
  final _pillowLengthCtrl = TextEditingController(text: '70');

  @override
  void dispose() {
    _duvetWidthCtrl.dispose();
    _duvetLengthCtrl.dispose();
    _sheetWidthCtrl.dispose();
    _sheetLengthCtrl.dispose();
    _pillowWidthCtrl.dispose();
    _pillowLengthCtrl.dispose();
    super.dispose();
  }

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

  void _onSizeChanged(ProductType type, String widthStr, String lengthStr) {
    final width = double.tryParse(widthStr) ?? 0.0;
    final length = double.tryParse(lengthStr) ?? 0.0;

    ref.read(orderProvider.notifier).updateCustomSizes(type, width, length);
  }

  @override
  Widget build(BuildContext context) {
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
                child: fabric.imageUrl.startsWith('http')
                    ? Image.network(
                        fabric.imageUrl,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 180,
                          color: Colors.grey.shade200,
                          child: const Center(child: Icon(Icons.image_not_supported)),
                        ),
                      )
                    : Image.asset(
                        fabric.imageUrl,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 180,
                          color: Colors.grey.shade200,
                          child: const Center(child: Icon(Icons.image_not_supported)),
                        ),
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
              // стандартные размеры
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
              // кастомные размеры
              if (orderState.currentSet.type == BeddingSetType.custom) ...[
                const SizedBox(height: 24),
                const Text(
                  'Введите ваши размеры (в сантиметрах):',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                ),
                const SizedBox(height: 16),

                _buildSizeInput('Пододеяльник', _duvetWidthCtrl, _duvetLengthCtrl, ProductType.duvetCover),
                _buildSizeInput('Простыня', _sheetWidthCtrl, _sheetLengthCtrl, ProductType.sheet),
                _buildSizeInput('Наволочка', _pillowWidthCtrl, _pillowLengthCtrl, ProductType.pillowcase),

                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Простыня на резинке (+500 Руб.)'),
                  value: isElastic,
                  onChanged: (bool? value) {
                    ref.read(orderProvider.notifier).toggleElastic(value ?? false);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ],
              
              const SizedBox(height: 32),

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
                    ref.read(cartProvider.notifier).addItem(orderState);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Комплект добавлен в корзину'), duration: Duration(seconds: 2)),
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text('В корзину', style: TextStyle(fontSize: 16)),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
  Widget _buildSizeInput(String label, TextEditingController widthCtrl, TextEditingController lengthCtrl, ProductType type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14))
          ),
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: widthCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ширина',
                suffixText: 'см',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              onChanged: (value) => _onSizeChanged(type, widthCtrl.text, lengthCtrl.text),   
            )
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: lengthCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Длина',
                suffixText: 'см',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              onChanged: (value) => _onSizeChanged(type, widthCtrl.text, lengthCtrl.text),   
            )
          ),
        ],
      ), 
    );
  }
}