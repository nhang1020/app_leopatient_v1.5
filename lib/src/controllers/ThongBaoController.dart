import 'dart:convert';
import 'package:app/src/models/ThongBao.dart';

import '../APIs/routes.dart';
import 'localData.dart';
import 'package:http/http.dart' as http;

class ThongBaoController {
  APIs _api = APIs();
  LocalData localData = LocalData();

  Future<List<ThongBaoData>> getThongBao() async {
    List<ThongBaoData> list = [];
    try {
      String token = await localData.Shared_getToken();
      final response = await http.get(
        Uri.parse(_api.Url_DanhSachThongBao()),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        list = ThongBao.fromJson(jsonDecode(response.body)).data;
      }
    } catch (e) {
      print(e);
    }
    return list;
  }
}
