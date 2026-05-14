import '../../domain/entities/fabric.dart';
import '../../domain/repositories/i_fabric_repository.dart';
import '../datasources/mock_data.dart';

class FabricRepositoryImpl implements IFabricRepository {
  @override
  Future<List<Fabric>> getFabrics() async {
    // возвращаем mock data с задержкой, имитируя сетевой запрос
    await Future.delayed(const Duration(seconds: 1));
    return mockFabrics;
  }
}