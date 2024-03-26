import 'dart:convert';

import '../APIs/routes.dart';
import '../models/LichSuKhamChiTiet.dart';
import 'localData.dart';
import 'package:http/http.dart' as http;

class LichSuKhamChiTietController {
  APIs _api = APIs();
  LocalData localData = LocalData();


  Future<LskChiTietData> getLichSuKham(String idkh, String mahs) async {
    LskChiTietData get = LskChiTietData(dvtk: [], thuoc: []);

    String token = await localData.Shared_getToken();
    final response = await http.post(
      Uri.parse(_api.Url_LichSuKhamChiTiet()),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        "idkh": idkh,
        "mahs": mahs,
      },
    );
    if (response.statusCode == 200) {
      var data = LichSuKhamChiTiet.fromJson(jsonDecode(response.body));

      get = data.data;
    }
    return get;
  }
}
