import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postelnoe_app/presentation/providers/order_provider.dart';
import '../../domain/entities/fabric.dart';
import '../../data/datasources/mock_data.dart'; // тестовые данные

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Set<String> categories = mockFabrics.map((f) => f.materialName).toSet();
    final List<String> tabs = categories.toList();

    return DefaultTabController(
      length: tabs.length, // количество вкладок = количеству материалов
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Каталог тканей'),
          bottom: TabBar(
            isScrollable: true, 
            tabs: tabs.map((name) => Tab(text: name)).toList(),
          ),
        ),
        body: TabBarView(
          // для каждой вкладки свой экран
          children: tabs.map((categoryName) {
            final categoryFabrics = mockFabrics
                .where((fabric) => fabric.materialName == categoryName)
                .toList();

            return _FabricGrid(fabrics: categoryFabrics);
          }).toList(),
        ),
      ),
    );
  }
}

// сетка товаров
class _FabricGrid extends ConsumerWidget {
  final List<Fabric> fabrics;

  const _FabricGrid({required this.fabrics});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 товара в ряд
        childAspectRatio: 0.75, // соотношение сторон карточки
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: fabrics.length,
      itemBuilder: (context, index) {
        final fabric = fabrics[index];
        return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: () {
              // переход к конструктору заказа
              ref.read(orderProvider.notifier).selectFabric(fabric);
              print('Выбрана ткань: ${fabric.patternName}');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // картинка ткани
                Expanded(
                  child: Image.asset(
                    fabric.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => 
                        const Center(child: Icon(Icons.image_not_supported)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fabric.patternName, 
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        fabric.materialName, 
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}