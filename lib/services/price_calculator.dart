import '../models/bedding_set_type.dart';
import '../models/fabric.dart';
import '../models/product_item.dart';

class PriceCalculator {
  static const int elasticSheetExtraPrice = 500; // Наценка за резинку в рублях (для стандартов)

  /// Главный метод расчета
  int calculatePrice({
    required Fabric fabric,
    required BeddingSet set,
  }) {
    // 1. Проверяем, есть ли фиксированная цена в прайс-листе ткани
    // (Это работает для Стандартных типов: Евро, 1.5-сп и т.д.)
    if (fabric.prices.containsKey(set.type) && set.type != BeddingSetType.custom) {
      int basePrice = fabric.prices[set.type]!;
      
      // Проверяем, есть ли в наборе простыня на резинке
      // Мы ищем в списке предметов хоть один предмет типа "sheet" с флагом elastic
      bool hasElastic = set.items.any((item) => 
        item.type == ProductType.sheet && item.elastic == true
      );

      return hasElastic ? basePrice + elasticSheetExtraPrice : basePrice;
    }

    return _calculateCustomPrice(fabric, set);
  }

  int _calculateCustomPrice(Fabric fabric, BeddingSet set) {
    double totalArea = set.totalFabricRequirement();

    // Превращаем площадь в погонные метры (делим на ширину рулона, обычно 2.2м или 2.4м)
    // Допустим, стандартная ширина рулона 2.2м
    double linearMeters = totalArea / 2.2; 

    // Стоимость материалов
    double materialCost = linearMeters * fabric.pricePerMeter;

    // Итоговая формула:  // себестоимость материалов (цена за метр*количество на изделие) + 150 + работа(>= 100% от себестоимость)
    double finalPrice = materialCost + 1.5 * materialCost + 150;

    // Округляем до сотен (чтобы цена была красивой, например 4200, а не 4187)
    return (finalPrice / 100).ceil() * 100;
  }
}