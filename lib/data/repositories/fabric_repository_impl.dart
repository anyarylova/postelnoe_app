import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/fabric.dart';
import '../../domain/repositories/i_fabric_repository.dart';

class FabricRepositoryImpl implements IFabricRepository {
  static const String _baseUrl = String.fromEnvironment('FABRICS_API_URL');
  static const String _token = String.fromEnvironment('API_TOKEN');

  @override
  Future<List<Fabric>> getFabrics() async {
    if (_baseUrl.isEmpty) {
      throw Exception('URL таблицы не задан. Укажите FABRICS_API_URL при запуске.');
    }

    final uri = Uri.parse(_token.isNotEmpty ? '$_baseUrl?token=$_token' : _baseUrl);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((item) => Fabric.fromJson(item as Map<String, dynamic>))
          .where((fabric) => fabric.isAvailable) // отображаем только доступные ткани
          .toList();
    } else {
      throw Exception('Ошибка загрузки данных из таблицы: ${response.statusCode}');
    }
  }
}