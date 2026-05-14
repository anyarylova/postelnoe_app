import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/fabric.dart';
import 'repository_provider.dart';

final catalogProvider = FutureProvider<List<Fabric>>((ref) async {
  final repository = ref.watch(fabricRepositoryProvider);
  return await repository.getFabrics();
});