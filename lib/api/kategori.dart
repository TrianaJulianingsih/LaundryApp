import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:laundry_app/api/endpoint/endpoint.dart';
import 'package:laundry_app/models/kategori.dart';
import 'package:laundry_app/preference/shared_preference.dart';

class KategoriAPI {
  // static Future<Map<String, dynamic>> addKategori({
  //   required String name,
  //   File? image,
  // }) async {
  //   final url = Uri.parse(Endpoint.kategori);
  //   final token = await PreferenceHandler.getToken();

  //   final response = await http.post(
  //     url,
  //     body: {"name": name},
  //     headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
  //   );

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     return json.decode(response.body);
  //   } else {
  //     final error = json.decode(response.body);
  //     throw Exception(error["message"] ?? "Tambah kategori gagal");
  //   }
  // }
  static Future<Map<String, dynamic>> addKategori({
    required String name,
    File? image,
  }) async {
    final url = Uri.parse(Endpoint.kategori);
    final token = await PreferenceHandler.getToken();

    var request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });
    request.fields['name'] = name;
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    final response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(respStr);
    } else {
      final error = json.decode(respStr);
      throw Exception(error["message"] ?? "Tambah kategori gagal");
    }
  }

  static Future<KategoriModel> getKategori() async {
    final url = Uri.parse(Endpoint.kategori);
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

  static Future<KategoriModel> postCategory({
    required String name,
    required File image,
  }) async {
    final url = Uri.parse(Endpoint.kategori);
    final token = await PreferenceHandler.getToken();
    final readImage = image.readAsBytesSync();
    final b64 = base64Encode(readImage);
    final response = await http.post(
      url,
      body: {"name": name, "image": b64},
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );
    print(image);
    print(readImage);
    print(b64);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return KategoriModel.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      throw Exception(error["message"] ?? "Register gagal");
    }
  }

  static Future<void> hapusKategori(int id) async {
    final token = await PreferenceHandler.getToken();

    final response = await http.delete(
      Uri.parse("${Endpoint.kategori}/$id"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      final error = json.decode(response.body);
      throw Exception(error["message"] ?? "Gagal hapus kategori");
    }
  }
}
