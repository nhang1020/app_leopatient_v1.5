import 'dart:convert';

import 'package:app/src/models/TinNhanThongBao.dart';
import 'package:app/src/models/User_Pass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  Future Shared_SaveAccount(String json) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('Account', json);
    } catch (e) {
      // ignore: invalid_use_of_visible_for_testing_member
      SharedPreferences.setMockInitialValues({});
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('Account', json);
    }
  }

  Future<User_Pass?> Shared_GetAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('Account');
    if (json != null) {
      User_Pass taiKhoan = User_Pass.fromJson(jsonDecode(json.toString()));
      return taiKhoan;
    } else {
      return null;
    }
  }

  Future<String> Shared_getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('Account');
    User_Pass taiKhoan = User_Pass.fromJson(jsonDecode(json.toString()));
    return taiKhoan.toKen;
  }

  Future<int> Shared_getID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('Account');
    User_Pass taiKhoan = User_Pass.fromJson(jsonDecode(json.toString()));
    return taiKhoan.idkh;
  }

  Shared_saveThongBao(TinNhanThongBao thongbao) async {
    thongbao.daxem = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = tinNhanThongBaoToJson(thongbao);
    List<String> list = prefs.getStringList('thongbao') ?? [];
    if (!list.contains(data)) {
      prefs.setStringList('thongbao', list + [data]);
    }
  }

  Future<List<TinNhanThongBao>> Shared_getThongBao() async {
    TinNhanThongBao? tb;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = await prefs.getStringList('thongbao') ?? [];
    List<TinNhanThongBao> listTB = [];
    for (var item in list) {
      tb = TinNhanThongBao.fromJson(jsonDecode(item));
      listTB.add(tb);
    }
    return listTB;
  }

  Future<int> Shared_getSoLuongThongBao() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = await prefs.getStringList('thongbao') ?? [];
    int SLThongBao = 0;
    for (var item in list) {
      if (TinNhanThongBao.fromJson(jsonDecode(item)).daxem == null ||
          TinNhanThongBao.fromJson(jsonDecode(item)).daxem == false) {
        SLThongBao = SLThongBao + 1;
      }
    }
    return SLThongBao;
  }

  Shared_seenThongBao(TinNhanThongBao thongbao) async {
    thongbao.daxem = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = await prefs.getStringList('thongbao') ?? [];
    var data = tinNhanThongBaoToJson(thongbao);
    list = list.map((item) {
      if (TinNhanThongBao.fromJson(jsonDecode(item)).thoigian ==
          thongbao.thoigian) {
        item = data;
      }
      return item;
    }).toList();
    prefs.setStringList('thongbao', list);
  }

  Shared_clearThongBao() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('thongbao');
  }
}
