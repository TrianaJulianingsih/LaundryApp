import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:laundry_app/api/endpoint/endpoint.dart';
import 'package:laundry_app/models/order_model.dart';
import 'package:laundry_app/models/register_model.dart';
import 'package:laundry_app/preference/shared_preference.dart';

class AuthenticationAPI {
  static Future<GetProfile> addOrder({
    required String layanan,
    required String service,
    required int item,
    required String metodePembayaran,
    required int totalItem,
    required String harga,
  }) async {
    final url = Uri.parse(Endpoint.order);
    final response = await http.post(
      url,
      body: {"layanan": layanan, "service": service, "item": item, "metode_pembayaran": metodePembayaran, "total_item": totalItem, "harga": harga},
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      return GetProfile.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      throw Exception(error["message"] ?? "Register gagal");
    }
  }

}
