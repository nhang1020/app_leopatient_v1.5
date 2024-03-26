import 'dart:convert';

import 'package:app/src/APIs/routes.dart';
import 'package:app/src/controllers/localData.dart';
import 'package:app/src/controllers/notification_manager/notification_helper.dart';
import 'package:app/src/models/TaiKhoan.dart';
import 'package:app/src/controllers/notification_manager/firebase_notification.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/auth/changePassword_screen.dart';
import 'package:app/src/views/widgets/notifications.dart';
import 'package:app/src/views/widgets/rootWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User_Pass.dart';

class DangNhapController {
  APIs _api = APIs();
  LocalData localData = LocalData();
  User_Pass userpass =
      User_Pass(userName: '', passWork: '', toKen: '0', idkh: 0);
  Future handleLogin(String tenDangNhap, String matKhau, bool luuDangNhap,
      BuildContext context) async {
    try {
      final response = await http.post(Uri.parse(_api.Url_DangNhap()), body: {
        'tendangnhap': tenDangNhap,
        'matkhau': matKhau,
      });
      if (response.statusCode == 200) {
        TaiKhoan taiKhoan = TaiKhoan.fromJson(jsonDecode(response.body));

        if (luuDangNhap == true) {
          TaiKhoanData data = taiKhoan.data;
          userpass = User_Pass(
              userName: tenDangNhap,
              passWork: matKhau,
              toKen: data.token,
              idkh: data.idkh);
          String json = jsonEncode(userpass);

          localData.Shared_SaveAccount(json).then((value) async {
            await saveMessageToken();
          });
        }

        if (taiKhoan.data.doimatkhau == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangePasswork(
                  idkh: userpass.idkh,
                  first: true,
                ), //user_pass: userpass
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RootWidget(), //user_pass: userpass
              ));
          ScaffoldMessenger.of(context).showSnackBar(
              MyNotifications().successSnackBar("Đăng nhập thành công."));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(MyNotifications()
            .errorSnackBar("Tên đăng nhập hoặc mật khẩu không chính xác."));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(MyNotifications().errorSnackBar("$e"));
    }
  }

  Future<bool> saveMessageToken() async {
    try {
      String token = await localData.Shared_getToken();
      if (deviceToken != null) {
        final response = await http.post(
          Uri.parse(_api.Url_MegsLuuToken()),
          headers: {'Authorization': 'Bearer $token'},
          body: {
            "token": deviceToken,
          },
        );
        if (response.statusCode == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('messageToken', deviceToken);
        }
      }
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future showSchedule(DateTime? ngayHen) async {
    try {
      if (ngayHen != null) {
        DateTime date = DateTime(
          ngayHen.year,
          ngayHen.month,
          ngayHen.day,
          ngayHen.hour,
          ngayHen.minute,
        );
        if (date.difference(DateTime.now()).inDays >= 1 &&
            date.isAfter(DateTime.now())) {
          await NotificationHelper.scheduleNotification(
            id: convertDateTimeToInt(date.subtract(Duration(days: 1))),
            date: date.subtract(Duration(days: 1)),
            title: "Lịch khám bệnh",
            body:
                "Ngày mai bạn có một lịch khám bệnh vào lúc ${formatTime(date)} ngày ${formatDateVi2(date)}",
          );
        }
        await NotificationHelper.scheduleNotification(
          id: convertDateTimeToInt(date.subtract(Duration(hours: 3))),
          date: date.subtract(Duration(hours: 3)),
          title: "Lịch khám bệnh",
          body: "Hôm nay bạn có một lịch khám bệnh vào lúc ${formatTime(date)}",
        );

        await NotificationHelper.scheduleNotification(
          id: convertDateTimeToInt(date.subtract(Duration(hours: 1))),
          date: date.subtract(Duration(hours: 1)),
          title: "Lịch khám bệnh",
          body: "1 giờ bạn có một lịch khám bệnh vào lúc ${formatTime(date)}",
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
