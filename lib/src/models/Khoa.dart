// To parse this JSON data, do
//
//     final khoa = khoaFromJson(jsonString);

import 'dart:convert';

Khoa khoaFromJson(String str) => Khoa.fromJson(json.decode(str));

String khoaToJson(Khoa data) => json.encode(data.toJson());

class Khoa {
  bool success;
  List<KhoaData> data;
  String message;

  Khoa({
    required this.success,
    required this.data,
    required this.message,
  });

  factory Khoa.fromJson(Map<String, dynamic> json) => Khoa(
        success: json["success"],
        data:
            List<KhoaData>.from(json["data"].map((x) => KhoaData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class KhoaData {
  String makhoa;
  dynamic tenviettat;
  String tenkhoa;

  KhoaData({
    required this.makhoa,
    required this.tenviettat,
    required this.tenkhoa,
  });

  factory KhoaData.fromJson(Map<String, dynamic> json) => KhoaData(
        makhoa: json["makhoa"],
        tenviettat: json["tenviettat"],
        tenkhoa: json["tenkhoa"],
      );

  Map<String, dynamic> toJson() => {
        "makhoa": makhoa,
        "tenviettat": tenviettat,
        "tenkhoa": tenkhoa,
      };
}
