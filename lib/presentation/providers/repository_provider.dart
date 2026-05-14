import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/i_fabric_repository.dart';
import '../../data/repositories/fabric_repository_impl.dart';

final fabricRepositoryProvider = Provider<IFabricRepository>((ref) {
  return FabricRepositoryImpl();
});