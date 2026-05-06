import 'package:postelnoe_app/models/bedding_set_type.dart';

class Fabric {
  final String id;
  final String patternName;   // Название расцветки
  final String materialName;
  final String imageUrl;
  final double pricePerMeter;
  final bool isAvailable;

  final Map<BeddingSetType, int> prices;

  Fabric({
    required this.id,
    required this.patternName,
    required this.materialName,
    required this.imageUrl,
    required this.pricePerMeter,
    required this.isAvailable,
    required this.prices,
  });

  String get fullName => '$patternName ($materialName)';
}