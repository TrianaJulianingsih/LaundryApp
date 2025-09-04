// api/layanan.dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:laundry_app/api/endpoint/endpoint.dart';
import 'package:laundry_app/models/item_model.dart';
import 'package:laundry_app/preference/shared_preference.dart';

class LayananAPI {
  static Future<ItemModel> getLayananByCategory(int categoryId) async {
    final url = Uri.parse("${Endpoint.layanan}?category_id=$categoryId");
    final token = await PreferenceHandler.getToken();

    final response = await http.get(
      url,
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      throw Exception(error["message"] ?? "Gagal mengambil data layanan");
    }
  }

  static Future<ItemModel> getAllLayanan() async {
    final url = Uri.parse(Endpoint.layanan);
    final token = await PreferenceHandler.getToken();

    final response = await http.get(
      url,
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      throw Exception(error["message"] ?? "Gagal mengambil data layanan");
    }
  }
}
