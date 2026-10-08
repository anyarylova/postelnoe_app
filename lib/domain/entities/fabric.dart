import 'package:postelnoe_app/domain/entities/bedding_set_type.dart';

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

  factory Fabric.fromJson(Map<String, dynamic> json) {
    return Fabric(
      id: json['id']?.toString() ?? '',
      patternName: json['patternName']?.toString() ?? '',
      materialName: json['materialName']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
      pricePerMeter: double.tryParse(json['pricePerMeter']?.toString() ?? '0') ?? 0.0,
      isAvailable: json['isAvailable']?.toString().toLowerCase() == 'true',
      prices: {
        BeddingSetType.singleAndHalf: int.tryParse(json['price1,5']?.toString() ?? '0') ?? 0,
        BeddingSetType.doubleStandard: int.tryParse(json['price2']?.toString() ?? '0') ?? 0,
        BeddingSetType.doubleEuroSheet: int.tryParse(json['price2Euro']?.toString() ?? '0') ?? 0,
        BeddingSetType.euro: int.tryParse(json['priceEuro']?.toString() ?? '0') ?? 0,
        BeddingSetType.family: int.tryParse(json['priceFamily']?.toString() ?? '0') ?? 0,
      },
    );
  }
}