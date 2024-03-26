import 'dart:convert';

import 'package:app/src/APIs/routes.dart';
import 'package:app/src/controllers/localData.dart';
import 'package:app/src/models/serviceModel/DichVuKham.dart';
import 'package:app/src/models/serviceModel/LichDichVuKham.dart';
import 'package:http/http.dart' as http;

class LichDichVuKhamController {
  APIs _api = APIs();
  LocalData localData = LocalData();

  Future<List<LichDichVuKhamData>> getLichDichVuKham(String loaiKham,
      {String? maBacSi}) async {
    List<LichDichVuKhamData> get = [];
    try {
      String token = await localData.Shared_getToken();

      final response = await http.post(
        Uri.parse(_api.Url_LichDichVuKham()),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "loaikham": loaiKham,
          "ngaydangky": "",
          "makhoa": "",
          "maphong": "",
          "mabs": maBacSi ?? ""
        },
      );
      if (response.statusCode == 200) {
        var data = LichDichVuKham.fromJson(jsonDecode(response.body));

        get = data.data;
      }
    } catch (e) {
      print("e $e");
    }

    return get;
  }

  Future<List<GoiKhamSkChiTiet>> goiKhamSucKhoe(
      DateTime ngayKham, String? gioKham) async {
    List<GoiKhamSkChiTiet> _goiKham = [];
    try {
      String token = await localData.Shared_getToken();

      final response = await http.post(
        Uri.parse(_api.Url_GoiKhamSucKhoe()),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "loaikham": "KSK",
          "ngaydangky":
              "${ngayKham.year.toString().padLeft(4, '0')}-${ngayKham.month.toString().padLeft(2, '0')}-${ngayKham.day.toString().padLeft(2, '0')}",
          "gio": "${gioKham}"
        },
      );
      if (response.statusCode == 200) {
        var data = GoiKhamSk.fromJson(jsonDecode(response.body));
        _goiKham = data.data;
      }
    } catch (e) {
      print(e);
    }
    return _goiKham;
  }
}
