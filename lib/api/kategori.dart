import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:laundry_app/api/endpoint/endpoint.dart';
import 'package:laundry_app/models/kategori.dart';
import 'package:laundry_app/preference/shared_preference.dart';

class KategoriAPI {
  static Future<Map<String, dynamic>> addKategori({
    required String name,
  }) async {
    final url = Uri.parse(Endpoint.layanan);
    final token = await PreferenceHandler.getToken();

    final response = await http.post(
      url,
      body: {"name": name},
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      final error = json.decode(response.body);
      throw Exception(error["message"] ?? "Tambah kategori gagal");
    }
  }

  static Future<KategoriModel> getKategori() async {
    final url = Uri.parse(Endpoint.layanan);
    final token = await PreferenceHandler.getToken();
    final response = await http.get(
      url,
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );
    // print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return KategoriModel.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      print(error);
      throw Exception(error["message"] ?? "Register gagal");
    }
  }

  static Future<void> hapusKategori(int id) async {
    final token = await PreferenceHandler.getToken();

    final response = await http.delete(
      Uri.parse("${Endpoint.layanan}/$id"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      final error = json.decode(response.body);
      throw Exception(error["message"] ?? "Gagal hapus kategori");
    }
  }
}
