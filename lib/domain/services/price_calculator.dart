import '../entities/bedding_set_type.dart';
import '../entities/fabric.dart';
import '../entities/product_item.dart';

class PriceCalculator {
  static const int elasticSheetExtraPrice = 500; // наценка за резинку в рублях

  // главный метод расчета
  int calculatePrice({
    required Fabric fabric,
    required BeddingSet set,
  }) {
    if (fabric.prices.containsKey(set.type) && set.type != BeddingSetType.custom) {
      int basePrice = fabric.prices[set.type]!;
      
      // проверяем, есть ли в наборе простыня на резинке
      bool hasElastic = set.items.any((item) => 
        item.type == ProductType.sheet && item.elastic == true
      );

      return hasElastic ? basePrice + elasticSheetExtraPrice : basePrice;
    }

    return _calculateCustomPrice(fabric, set);
  }

  int _calculateCustomPrice(Fabric fabric, BeddingSet set) {
    double totalArea = set.totalFabricRequirement();
    bool hasElastic = set.items.any((item) => 
        item.type == ProductType.sheet && item.elastic == true
      );

    double linearMeters = totalArea / 2.2; 

    double materialCost = linearMeters * fabric.pricePerMeter;

    // итоговая формула:  
    // себестоимость материалов (цена за метр*количество на изделие) + 150 + работа(>= 100% от себестоимость)
    double finalPrice = materialCost + 1.5 * materialCost + 150;

    return hasElastic ? (finalPrice / 100).ceil() * 100 + elasticSheetExtraPrice : (finalPrice / 100).ceil() * 100;
  }
}