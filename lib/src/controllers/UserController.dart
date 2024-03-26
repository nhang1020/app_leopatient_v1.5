import 'dart:convert';
import 'package:app/src/controllers/localData.dart';
import 'package:app/src/models/User.dart';
import 'package:http/http.dart' as http;

import '../APIs/routes.dart';

class UserController {
  APIs _api = APIs();
  LocalData localData = LocalData();

  Future<UserData> getUser() async {
    UserData user = UserData(
        idkh: 0,
        hoten: '',
        gioitinh: '',
        ngaysinh: DateTime.now(),
        cccd: '',
        dienthoai: '',
        diachi: '',
        mabhxh: '',
        nghenghiep: '',
        ghichu: '',
        avatar: '');

    String token = await localData.Shared_getToken();

    final response = await http.get(
      Uri.parse(_api.Url_User()),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      var data = User.fromJson(jsonDecode(response.body));
      user = data.data;
    }
    return user;
  }

  Future<bool> updateAvatar(String idkh, String avatar) async {
    String token = await localData.Shared_getToken();
    final response = await http.post(Uri.parse(_api.Url_CapNhatAnhDaiDien()),
        body: {'idkh': idkh, 'base64_img': avatar},
        headers: {'Authorization': 'Bearer $token'});
    print('${response.statusCode} -' + response.body);
    if (response.statusCode == 200) {
      // final body = json.decode(response.body);body['data']['base64_img']
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }
}
