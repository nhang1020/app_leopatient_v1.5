// To parse this JSON data, do
//
//     final CCCD = CCCDFromJson(jsonString);

import 'dart:convert';

CCCD CCCDFromJson(String str) => CCCD.fromJson(json.decode(str));

String CCCDToJson(CCCD data) => json.encode(data.toJson());

class CCCD {
  dynamic soCCCD;
  dynamic soCmnd;
  dynamic ten;
  DateTime ngaySinh;
  dynamic gioiTinh;
  dynamic diaChi;
  DateTime ngayCap;
  dynamic qrcode;
  CCCD({
    required this.soCCCD,
    required this.soCmnd,
    required this.ten,
    required this.ngaySinh,
    required this.gioiTinh,
    required this.diaChi,
    required this.ngayCap,
    this.qrcode,
  });

  factory CCCD.fromJson(Map<String, dynamic> json) => CCCD(
      soCCCD: json["SoCCCD"],
      soCmnd: json["SoCMND"],
      ten: json["Ten"],
      ngaySinh: DateTime.parse(json["NgaySinh"]),
      gioiTinh: json["GioiTinh"],
      diaChi: json["DiaChi"],
      ngayCap: DateTime.parse(json["NgayCap"]),
      qrcode: json['qrcode']);

  Map<String, dynamic> toJson() => {
        "SoCCCD": soCCCD,
        "SoCMND": soCmnd,
        "Ten": ten,
        "NgaySinh":
            "${ngaySinh.year.toString().padLeft(4, '0')}-${ngaySinh.month.toString().padLeft(2, '0')}-${ngaySinh.day.toString().padLeft(2, '0')}",
        "GioiTinh": gioiTinh,
        "DiaChi": diaChi,
        "NgayCap":
            "${ngayCap.year.toString().padLeft(4, '0')}-${ngayCap.month.toString().padLeft(2, '0')}-${ngayCap.day.toString().padLeft(2, '0')}",
        "qrcode": qrcode
      };
}
