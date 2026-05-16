import 'package:postelnoe_app/domain/entities/bedding_set_type.dart';
import 'package:postelnoe_app/domain/entities/fabric.dart';

enum ProductType { pillowcase, duvetCover, sheet }

class BeddingSize {
  final String name;
  final double width;
  final double length;

  const BeddingSize({required this.name, required this.width, required this.length});
}

class ProductItem {
  final ProductType type;
  final double width;
  final double length;
  final bool? elastic; // Для простыней на резинке
  final Fabric? fabric;

  ProductItem({
    required this.type,
    required this.width,
    required this.length,
    this.elastic,
    this.fabric,
  });

  // расчет расхода ткани в кв.метрах
  double calculateArea() {
    double multiplier = (type == ProductType.sheet) ? 1.0 : 2.0;
    return ((width + 10) * (length + 10) * multiplier) / 10000;
  }
}

class BeddingSet {
  final BeddingSetType type;
  final List<ProductItem> items;

  BeddingSet({
    required this.type,
    required this.items,
  });

  factory BeddingSet.fromType(BeddingSetType type, {bool isElastic = false}) {
    switch (type) {
      case BeddingSetType.singleAndHalf:
        return BeddingSet(type: type, items: [
          ProductItem(type: ProductType.duvetCover, width: 145, length: 215),
          ProductItem(type: ProductType.sheet, width: 150, length: 220, elastic: isElastic),
          ProductItem(type: ProductType.pillowcase, width: 70, length: 70),
        ]);

      case BeddingSetType.doubleStandard:
        return BeddingSet(type: type, items: [
          ProductItem(type: ProductType.duvetCover, width: 175, length: 215),
          ProductItem(type: ProductType.sheet, width: 200, length: 220, elastic: isElastic),
          ProductItem(type: ProductType.pillowcase, width: 70, length: 70),
          ProductItem(type: ProductType.pillowcase, width: 70, length: 70),
        ]);

       case BeddingSetType.doubleEuroSheet:
        return BeddingSet(type: type, items: [
          ProductItem(type: ProductType.duvetCover, width: 175, length: 215),
          ProductItem(type: ProductType.sheet, width: 240, length: 260, elastic: isElastic),
          ProductItem(type: ProductType.pillowcase, width: 70, length: 70),
          ProductItem(type: ProductType.pillowcase, width: 70, length: 70),
        ]);

      case BeddingSetType.euro:
        return BeddingSet(type: type, items: [
          ProductItem(type: ProductType.duvetCover, width: 200, length: 220),
          ProductItem(type: ProductType.sheet, width: 240, length: 260, elastic: isElastic),
          ProductItem(type: ProductType.pillowcase, width: 50, length: 70),
          ProductItem(type: ProductType.pillowcase, width: 50, length: 70),
        ]);

      case BeddingSetType.family:
        return BeddingSet(type: type, items: [
          ProductItem(type: ProductType.duvetCover, width: 145, length: 215),
          ProductItem(type: ProductType.duvetCover, width: 145, length: 215),
          ProductItem(type: ProductType.sheet, width: 240, length: 260, elastic: isElastic),
          ProductItem(type: ProductType.pillowcase, width: 70, length: 70),
          ProductItem(type: ProductType.pillowcase, width: 70, length: 70),
        ]);

      case BeddingSetType.custom:
        return BeddingSet(type: type, items: [
          ProductItem(type: ProductType.duvetCover, width: 145, length: 215),
          ProductItem(type: ProductType.duvetCover, width: 145, length: 215),
          ProductItem(type: ProductType.sheet, width: 240, length: 260, elastic: isElastic),
          ProductItem(type: ProductType.pillowcase, width: 70, length: 70),
          ProductItem(type: ProductType.pillowcase, width: 70, length: 70),
        ]);
    }
  }

  double totalFabricRequirement() {
    return items.fold(0, (sum, item) => sum + item.calculateArea());
  }
}