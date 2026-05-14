import '../../domain/entities/fabric.dart';
import '../../domain/entities/bedding_set_type.dart';

final List<Fabric> mockFabrics = [
  Fabric(
    id: '1',
    patternName: 'Милашки',
    materialName: 'Бязь',
    imageUrl: 'assets/images/byaz/cuties.jpg',
    pricePerMeter: 450.0,
    isAvailable: true,
    prices: {
      BeddingSetType.singleAndHalf: 1900,
      BeddingSetType.doubleStandard: 2200,
      BeddingSetType.doubleEuroSheet: 2400,
      BeddingSetType.euro: 2600,
      BeddingSetType.family: 3200,
    },
  ),
  
  Fabric(
    id: '2',
    patternName: 'Синий',
    materialName: 'Страйп Сатин', // Другой материал -> Другие цены
    imageUrl: 'assets/images/stripe_satin/blue.jpg',
    pricePerMeter: 800.0,
    isAvailable: true,
    prices: {
      BeddingSetType.singleAndHalf: 3600,
      BeddingSetType.doubleStandard: 3900,
      BeddingSetType.doubleEuroSheet: 4200,
      BeddingSetType.euro: 4700,
      BeddingSetType.family: 6000,
    },
  ),

  Fabric(
    id: '3',
    patternName: 'Графит',
    materialName: 'Страйп Сатин', // Другой материал -> Другие цены
    imageUrl: 'assets/images/stripe_satin/grafit.jpg',
    pricePerMeter: 800.0,
    isAvailable: true,
    prices: {
      BeddingSetType.singleAndHalf: 3600,
      BeddingSetType.doubleStandard: 3900,
      BeddingSetType.doubleEuroSheet: 4200,
      BeddingSetType.euro: 4700,
      BeddingSetType.family: 6000,
    },
  ),

  Fabric(
    id: '4',
    patternName: 'Пыльная роза',
    materialName: 'Страйп Сатин', // Другой материал -> Другие цены
    imageUrl: 'assets/images/stripe_satin/dusty_rose.jpg',
    pricePerMeter: 800.0,
    isAvailable: true,
    prices: {
      BeddingSetType.singleAndHalf: 3600,
      BeddingSetType.doubleStandard: 3900,
      BeddingSetType.doubleEuroSheet: 4200,
      BeddingSetType.euro: 4700,
      BeddingSetType.family: 6000,
    },
  ),

  Fabric(
    id: '5',
    patternName: 'Первая любовь',
    materialName: 'Бязь',
    imageUrl: 'assets/images/byaz/first_love.jpg',
    pricePerMeter: 450.0,
    isAvailable: true,
    prices: {
      BeddingSetType.singleAndHalf: 1900,
      BeddingSetType.doubleStandard: 2200,
      BeddingSetType.doubleEuroSheet: 2400,
      BeddingSetType.euro: 2600,
      BeddingSetType.family: 3200,
    },
  ),

  Fabric(
    id: '6',
    patternName: 'Тропикана',
    materialName: 'Бязь',
    imageUrl: 'assets/images/byaz/tropikana.jpg',
    pricePerMeter: 450.0,
    isAvailable: true,
    prices: {
      BeddingSetType.singleAndHalf: 1900,
      BeddingSetType.doubleStandard: 2200,
      BeddingSetType.doubleEuroSheet: 2400,
      BeddingSetType.euro: 2600,
      BeddingSetType.family: 3200,
    },
  ),

  Fabric(
    id: '7',
    patternName: 'Джулия',
    materialName: 'Поплин',
    imageUrl: 'assets/images/poplin/julia.jpg',
    pricePerMeter: 450.0,
    isAvailable: true,
    prices: {
      BeddingSetType.singleAndHalf: 2100,
      BeddingSetType.doubleStandard: 2400,
      BeddingSetType.doubleEuroSheet: 2600,
      BeddingSetType.euro: 2900,
      BeddingSetType.family: 3500,
    },
  ),

  Fabric(
    id: '8',
    patternName: 'Киска',
    materialName: 'Поплин',
    imageUrl: 'assets/images/poplin/kitty.jpg',
    pricePerMeter: 450.0,
    isAvailable: true,
    prices: {
      BeddingSetType.singleAndHalf: 2100,
      BeddingSetType.doubleStandard: 2400,
      BeddingSetType.doubleEuroSheet: 2600,
      BeddingSetType.euro: 2900,
      BeddingSetType.family: 3500,
    },
  ),

  Fabric(
    id: '9',
    patternName: 'Вальс',
    materialName: 'Поплин',
    imageUrl: 'assets/images/poplin/waltz.jpg',
    pricePerMeter: 450.0,
    isAvailable: true,
    prices: {
      BeddingSetType.singleAndHalf: 2100,
      BeddingSetType.doubleStandard: 2400,
      BeddingSetType.doubleEuroSheet: 2600,
      BeddingSetType.euro: 2900,
      BeddingSetType.family: 3500,
    },
  ),
];