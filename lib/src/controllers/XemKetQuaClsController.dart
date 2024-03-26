import 'dart:convert';
import 'package:app/src/controllers/localData.dart';
import 'package:http/http.dart' as http;

import '../APIs/routes.dart';
import '../models/XemKetQuaCls.dart';

class XemKetQuaClsController {
  APIs _api = APIs();
  LocalData localData = LocalData();

  Future<String> getKetQuaCls(String? machidinh_dvct) async {
    String token = await localData.Shared_getToken();
    String out = '';
    try {
      final response = await http.post(Uri.parse(_api.Url_XemKetQuaCls()),
          body: {'machidinh_dvct': machidinh_dvct},
          headers: {'Authorization': 'Bearer $token'});
      print(response.body);
      if (response.statusCode == 200) {
        var data = XemKetQuaCls.fromJson(jsonDecode(response.body));
        out = data.data.link.toString();
      } else {
        var data = XemKetQuaClsFalse.fromJson(jsonDecode(response.body));
        out = data.message.toString();
      }
    } catch (e) {
      print(e);
    }
    return out;
  }
}
