import '../entities/fabric.dart';

abstract class IFabricRepository {
  Future<List<Fabric>> getFabrics();
}