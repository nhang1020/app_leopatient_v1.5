import 'dart:convert';

import '../APIs/routes.dart';
import '../models/LichSuKham.dart';
import 'localData.dart';
import 'package:http/http.dart' as http;

class LichSuKhamController {
  APIs _api = APIs();
  LocalData localData = LocalData();

  Future<List<LichSuKhamData>> getLichSuKham(String idkh) async {
    List<LichSuKhamData> get = [];

    String token = await localData.Shared_getToken();

    final response = await http.post(
      Uri.parse(_api.Url_LichSuKham()),
      headers: {'Authorization': 'Bearer $token'},
      body: {"idkh": idkh},
    );
    if (response.statusCode == 200) {
      var data = LichSuKham.fromJson(jsonDecode(response.body));

      get = data.data;
    }
    return get;
  }
}
