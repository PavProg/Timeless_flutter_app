import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/catalog_item_model.dart';

class ApiService {
  // Локальный адрес ПК. После развертывание на сервере заменить на ip сервера
  static const String _baseUrl = 'http://192.168.1.100:8000/products';

  Future<List<CatalogItemModel>> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/products'),
        headers: {'Accept': 'application/json'}
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => CatalogItemModel.fromJson(json)).toList();
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Ошибка загрузки товаров: $e');
      rethrow;
    }
  }

  Future<CatalogItemModel> updateQuantity ({
    required int productId,
    required int weight,
    required int newQuantity,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/products/$productId/changes'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'weight_options': [
            {'weight': weight, 'quantity': newQuantity}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return CatalogItemModel.fromJson(data['after']);
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Ошибка обновления количества: $e');
      rethrow;
    }
  }

  Future<bool> addProduct(CatalogItemModel item) async {
    try {
      final responce = await http.post(
        Uri.parse('$_baseUrl/products'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(item.toJson()),
      );
      return responce.statusCode == 200;
    } catch (e) {
      print('Ошибка добавления товара: $e');
      return false;
    }
  }

  Future<bool> deleteProduct(int productId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/products/$productId'),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Ошибка удаления товара: $e');
      return false;
    }
  }
}
