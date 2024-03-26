import 'dart:convert';

import 'package:app/src/APIs/routes.dart';
import 'package:app/src/controllers/localData.dart';
import 'package:app/src/models/serviceModel/DichVuKham.dart';
import 'package:http/http.dart' as http;

class DichVuKhamController {
  APIs _api = APIs();
  LocalData localData = LocalData();

  Future<List<DichVuKhamData>> getLoaiDichVuKham(String loaiKham) async {
    List<DichVuKhamData> get = [];
    try {
      String token = await localData.Shared_getToken();

      final response = await http.post(
        Uri.parse(_api.Url_DichVuKham()),
        headers: {'Authorization': 'Bearer $token'},
        body: {"loaikham": loaiKham},
      );
      if (response.statusCode == 200) {
        var data = DichVuKham.fromJson(jsonDecode(response.body));

        get = data.data;
      }
    } catch (e) {
      print("e $e");
    }

    return get;
  }
}
