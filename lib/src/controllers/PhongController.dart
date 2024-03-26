import 'dart:convert';
import 'package:app/src/models/Phong.dart';
import '../APIs/routes.dart';
import 'localData.dart';
import 'package:http/http.dart' as http;

class PhongController {
  APIs _api = APIs();
  LocalData localData = LocalData();

  Future<List<PhongData>> getPhong(String? maPhong) async {
    List<PhongData> get = [];
    try {
      String token = await localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_DanhSachPhong()),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "maphong": maPhong,
        },
      );
      if (response.statusCode == 200) {
        var data = Phong.fromJson(jsonDecode(response.body));
        get = data.data;
      }
    } catch (e) {
      print(e);
    }

    return get;
  }
}
