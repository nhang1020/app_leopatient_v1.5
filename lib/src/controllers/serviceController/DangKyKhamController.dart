import 'dart:convert';

import 'package:app/src/APIs/routes.dart';
import 'package:app/src/controllers/localData.dart';
import 'package:app/src/views/screens/service/provider/class.dart';
import 'package:http/http.dart' as http;

class DangKyKhamController {
  APIs _api = APIs();
  LocalData localData = LocalData();
//
  Future<dynamic> postDangKyKham(
      LichKham lichKham, DangKyKham dangKyKham) async {
    DkOutput output = DkOutput(success: false);

    try {
      String token = await localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_DangKyKham()),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "loaikham": '${lichKham.loaiKham.loaiKham}',
          "ngaydangky":
              "${lichKham.ngayDangKy.year.toString().padLeft(4, '0')}-${lichKham.ngayDangKy.month.toString().padLeft(2, '0')}-${lichKham.ngayDangKy.day.toString().padLeft(2, '0')}",
          "gio": "${lichKham.gioKham}",
          "makhoa": '${lichKham.khoa.maKhoa}',
          "maphong": '${lichKham.bacSi.phong.maPhong}',
          "mabs": lichKham.bacSi.maBacSi,
          "loaithe": "${dangKyKham.loaithe}",
          "sothe": "${dangKyKham.sothe}",
          "hoten": "${dangKyKham.hoten}",
          "ngaysinh":
              "${dangKyKham.ngaysinh.day}/${dangKyKham.ngaysinh.month}/${dangKyKham.ngaysinh.year}",
          "qrcode": "${dangKyKham.qrcode}"
          // "loaithe": "CCCD",
          // "sothe": "0123456789",
          // "hoten": "Vo Van Tay",
          // "ngaysinh": "01/01/1992",
          // "qrcode": ""
        },
      );
      if (response.statusCode == 200) {
        output = DkOutput.fromJson(jsonDecode(response.body));
        return output;
      }
    } catch (e) {
      print("e $e");
    }

    return output;
  }

  Future<dynamic> postDangKyKhamSK(LichKham lichKham, String maGoi_KSK) async {
    DkOutput output = DkOutput(success: false);

    try {
      String token = await localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_DangKyKhamSucKhoe()),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "loaikham": '${lichKham.loaiKham.loaiKham}',
          "ngaydangky":
              "${lichKham.ngayDangKy.year.toString().padLeft(4, '0')}-${lichKham.ngayDangKy.month.toString().padLeft(2, '0')}-${lichKham.ngayDangKy.day.toString().padLeft(2, '0')}",
          "gio": "${lichKham.gioKham}",
          "makhoa": '${lichKham.khoa.maKhoa}',
          "maphong": '${lichKham.bacSi.phong.maPhong}',
          "mabs": '${lichKham.bacSi.maBacSi}',
          "magoidv": '${maGoi_KSK}'
        },
      );
      if (response.statusCode == 200) {
        output = DkOutput.fromJson(jsonDecode(response.body));
        return output;
      }
    } catch (e) {
      print("e $e");
    }

    return output;
  }
}

DangKyKham dangKyKhamFromJson(String str) =>
    DangKyKham.fromJson(json.decode(str));

String dangKyKhamToJson(DangKyKham data) => json.encode(data.toJson());

class DangKyKham {
  dynamic loaithe;
  dynamic sothe;
  dynamic hoten;
  DateTime ngaysinh;
  dynamic qrcode;

  DangKyKham({
    required this.loaithe,
    this.sothe,
    this.hoten,
    required this.ngaysinh,
    this.qrcode,
  });

  factory DangKyKham.fromJson(Map<String, dynamic> json) => DangKyKham(
        loaithe: json["loaithe"],
        sothe: json["sothe"],
        hoten: json["hoten"],
        ngaysinh: json["ngaysinh"],
        qrcode: json["qrcode"],
      );

  Map<String, dynamic> toJson() => {
        "loaithe": loaithe,
        "sothe": sothe,
        "hoten": hoten,
        "ngaysinh": ngaysinh,
        "qrcode": qrcode,
      };
}

DkOutput dkOutputFromJson(String str) => DkOutput.fromJson(json.decode(str));

String dkOutputToJson(DkOutput data) => json.encode(data.toJson());

class DkOutput {
  bool success;
  dynamic message;
  dynamic data;

  DkOutput({
    required this.success,
    this.message,
    this.data,
  });

  factory DkOutput.fromJson(Map<String, dynamic> json) => DkOutput(
        success: json["success"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}

DangKyKhamSk dangKyKhamSkFromJson(String str) =>
    DangKyKhamSk.fromJson(json.decode(str));

String dangKyKhamSkToJson(DangKyKhamSk data) => json.encode(data.toJson());

class DangKyKhamSk {
  dynamic loaikham;
  DateTime ngaydangky;
  dynamic gio;
  dynamic makhoa;
  dynamic maphong;
  dynamic mabs;
  dynamic magoidv;

  DangKyKhamSk({
    required this.loaikham,
    required this.ngaydangky,
    required this.gio,
    required this.makhoa,
    required this.maphong,
    required this.mabs,
    required this.magoidv,
  });

  factory DangKyKhamSk.fromJson(Map<String, dynamic> json) => DangKyKhamSk(
        loaikham: json["loaikham"],
        ngaydangky: DateTime.parse(json["ngaydangky"]),
        gio: json["gio"],
        makhoa: json["makhoa"],
        maphong: json["maphong"],
        mabs: json["mabs"],
        magoidv: json["magoidv"],
      );

  Map<String, dynamic> toJson() => {
        "loaikham": loaikham,
        "ngaydangky":
            "${ngaydangky.year.toString().padLeft(4, '0')}-${ngaydangky.month.toString().padLeft(2, '0')}-${ngaydangky.day.toString().padLeft(2, '0')}",
        "gio": gio,
        "makhoa": makhoa,
        "maphong": maphong,
        "mabs": mabs,
        "magoidv": magoidv,
      };
}
