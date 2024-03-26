import 'dart:convert';
import 'package:app/src/models/Khoa.dart';
import '../APIs/routes.dart';
import 'localData.dart';
import 'package:http/http.dart' as http;

class KhoaController {
  APIs _api = APIs();
  LocalData localData = LocalData();

  Future<List<KhoaData>> getKhoa(String? maKhoa) async {
    List<KhoaData> get = [];
    try {
      String token = await localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_DanhSachKhoa()),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "makhoa": maKhoa,
        },
      );
      if (response.statusCode == 200) {
        var data = Khoa.fromJson(jsonDecode(response.body));

        get = data.data;
      }
    } catch (e) {
      print(e);
    }

    return get;
  }
}
