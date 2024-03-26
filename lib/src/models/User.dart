// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  bool success;
  UserData data;
  String message;

  User({
    required this.success,
    required this.data,
    required this.message,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        success: json["success"],
        data: UserData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class UserData {
  dynamic idkh;
  dynamic hoten;
  dynamic gioitinh;
  DateTime ngaysinh;
  dynamic cccd;
  dynamic dienthoai;
  dynamic diachi;
  dynamic mabhxh;
  dynamic nghenghiep;
  dynamic ghichu;
  dynamic avatar;

  UserData({
    this.idkh,
    this.hoten,
    this.gioitinh,
    required this.ngaysinh,
    this.cccd,
    this.dienthoai,
    this.diachi,
    this.mabhxh,
    this.nghenghiep,
    this.ghichu,
    this.avatar,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        idkh: json["idkh"],
        hoten: json["hoten"],
        gioitinh: json["gioitinh"],
        ngaysinh: DateTime.parse(json["ngaysinh"]),
        cccd: json["cccd"],
        dienthoai: json["dienthoai"],
        diachi: json["diachi"],
        mabhxh: json["mabhxh"],
        nghenghiep: json["nghenghiep"],
        ghichu: json["ghichu"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "idkh": idkh,
        "hoten": hoten,
        "gioitinh": gioitinh,
        "ngaysinh":
            "${ngaysinh.year.toString().padLeft(4, '0')}-${ngaysinh.month.toString().padLeft(2, '0')}-${ngaysinh.day.toString().padLeft(2, '0')}",
        "cccd": cccd,
        "dienthoai": dienthoai,
        "diachi": diachi,
        "mabhxh": mabhxh,
        "nghenghiep": nghenghiep,
        "ghichu": ghichu,
        "avatar": avatar,
      };
}

UserData initUser = UserData(
  idkh: 0,
  ngaysinh: DateTime.now(),
  hoten: "",
);
