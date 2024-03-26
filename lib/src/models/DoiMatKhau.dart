// To parse this JSON data, do
//
//     final doiMatKhau = doiMatKhauFromJson(jsonString);

import 'dart:convert';

DoiMatKhau doiMatKhauFromJson(String str) =>
    DoiMatKhau.fromJson(json.decode(str));

String doiMatKhauToJson(DoiMatKhau data) => json.encode(data.toJson());

class DoiMatKhau {
  bool success;
  //List<dynamic> data;
  dynamic message;

  DoiMatKhau({
    required this.success,
    //required this.data,
    required this.message,
  });

  factory DoiMatKhau.fromJson(Map<String, dynamic> json) => DoiMatKhau(
        success: json["success"],
        //data: List<dynamic>.from(json["data"].map((x) => x)),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        //"data": List<dynamic>.from(data.map((x) => x)),
        "message": message,
      };
}

class InputDoiMatKhau {
  dynamic idkh;
  dynamic matkhauOld;
  dynamic matkhauNew;
  dynamic matkhauConfirm;

  InputDoiMatKhau({
    required this.idkh,
    required this.matkhauOld,
    required this.matkhauNew,
    required this.matkhauConfirm,
  });

  factory InputDoiMatKhau.fromJson(Map<String, dynamic> json) =>
      InputDoiMatKhau(
        idkh: json["idkh"],
        matkhauOld: json["matkhau_old"],
        matkhauNew: json["matkhau_new"],
        matkhauConfirm: json["matkhau_confirm"],
      );

  Map<String, dynamic> toJson() => {
        "idkh": idkh,
        "matkhau_old": matkhauOld,
        "matkhau_new": matkhauNew,
        "matkhau_confirm": matkhauConfirm,
      };
}
