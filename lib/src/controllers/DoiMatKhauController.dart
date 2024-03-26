import 'dart:convert';
import 'package:app/src/models/DoiMatKhau.dart';

import '../APIs/routes.dart';
import 'localData.dart';
import 'package:http/http.dart' as http;

class DoiMatKhauController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<DoiMatKhau> postDoiMatKhau(InputDoiMatKhau input) async {
    DoiMatKhau output = DoiMatKhau(success: false, message: '');

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_DoiMatKhau()),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "idkh": input.idkh.toString(),
          "matkhau_old": input.matkhauOld,
          "matkhau_new": input.matkhauNew,
          "matkhau_confirm": input.matkhauConfirm,
        },
      );
      var data = DoiMatKhau.fromJson(jsonDecode(response.body));
      output = data;
      return output;
    } catch (e) {
      print(e);
    }
    return output;
  }
}
