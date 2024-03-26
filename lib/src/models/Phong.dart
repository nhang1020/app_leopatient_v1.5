// To parse this JSON data, do
//
//     final phong = phongFromJson(jsonString);

import 'dart:convert';

Phong phongFromJson(String str) => Phong.fromJson(json.decode(str));

String phongToJson(Phong data) => json.encode(data.toJson());

class Phong {
  bool success;
  List<PhongData> data;
  String message;

  Phong({
    required this.success,
    required this.data,
    required this.message,
  });

  factory Phong.fromJson(Map<String, dynamic> json) => Phong(
        success: json["success"],
        data: List<PhongData>.from(
            json["data"].map((x) => PhongData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class PhongData {
  String maphong;
  dynamic tenviettat;
  String tenphong;

  PhongData({
    required this.maphong,
    required this.tenviettat,
    required this.tenphong,
  });

  factory PhongData.fromJson(Map<String, dynamic> json) => PhongData(
        maphong: json["maphong"],
        tenviettat: json["tenviettat"],
        tenphong: json["tenphong"],
      );

  Map<String, dynamic> toJson() => {
        "maphong": maphong,
        "tenviettat": tenviettat,
        "tenphong": tenphong,
      };
}
