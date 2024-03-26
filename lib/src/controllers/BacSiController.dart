import 'dart:convert';
import 'package:app/src/models/BacSi.dart';
import '../APIs/routes.dart';
import 'localData.dart';
import 'package:http/http.dart' as http;

class BacSiController {
  APIs _api = APIs();
  LocalData localData = LocalData();

  Future<List<BacSiData>> getBacSi(String? maPhong, String? maKhoa) async {
    List<BacSiData> get = [];
    try {
      String token = await localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_DanhSachBacSi()),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "maphong": maPhong,
          "makhoa": maKhoa,
        },
      );
      if (response.statusCode == 200) {
        get = BacSi.fromJson(jsonDecode(response.body)).data;
      }
    } catch (e) {
      print(e);
    }
    return get;
  }

  Future<OutputDanhGia> danhGiaBacSi(String maBs, String danhGia) async {
    OutputDanhGia get = OutputDanhGia(mabs: '', danhgia: 0.0, luotdanhgia: 0);
    try {
      String token = await localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_DanhGiaBacSi()),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "mabs": maBs,
          "danhgia": danhGia,
        },
      );
      get = OutputDanhGia.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
    }

    return get;
  }
}
