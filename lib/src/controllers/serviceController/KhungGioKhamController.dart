import 'dart:convert';

import 'package:app/src/APIs/routes.dart';
import 'package:app/src/controllers/localData.dart';
import 'package:app/src/models/serviceModel/KhungGioKham.dart';
import 'package:app/src/views/screens/service/provider/class.dart';
import 'package:http/http.dart' as http;

class KhungGioKhamController {
  APIs _api = APIs();
  LocalData localData = LocalData();

  Future<List<KhungGioKhamData>> getKhungGioKham(LichKham lichKham) async {
    List<KhungGioKhamData> get = [];
    try {
      String token = await localData.Shared_getToken();

      final response = await http.post(
        Uri.parse(_api.Url_KhungGioKham()),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "loaikham": lichKham.loaiKham.loaiKham,
          "ngaydangky":
              "${lichKham.ngayDangKy.year.toString().padLeft(4, '0')}-${lichKham.ngayDangKy.month.toString().padLeft(2, '0')}-${lichKham.ngayDangKy.day.toString().padLeft(2, '0')}",
          "makhoa": lichKham.khoa.maKhoa,
          "maphong": lichKham.bacSi.phong.maPhong,
          "mabs": lichKham.bacSi.maBacSi,
        },
      );
      if (response.statusCode == 200) {
        var data = KhungGioKham.fromJson(jsonDecode(response.body));

        get = data.data;
      }
    } catch (e) {
      print("$e");
    }

    return get;
  }
}
