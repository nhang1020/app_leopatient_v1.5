// To parse this JSON data, do
//
//     final bacSi = bacSiFromJson(jsonString);

import 'dart:convert';

BacSi bacSiFromJson(String str) => BacSi.fromJson(json.decode(str));

String bacSiToJson(BacSi data) => json.encode(data.toJson());

class BacSi {
  bool success;
  List<BacSiData> data;
  String message;

  BacSi({
    required this.success,
    required this.data,
    required this.message,
  });

  factory BacSi.fromJson(Map<String, dynamic> json) => BacSi(
        success: json["success"],
        data: List<BacSiData>.from(
            json["data"].map((x) => BacSiData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class BacSiData {
  String mabs;
  String tenbs;
  dynamic gioitinh;
  dynamic sodienthoai;
  dynamic email;
  dynamic hinhdaidien;
  dynamic trinhdo;
  dynamic chuyenmon;
  dynamic chuyenkhoa;
  dynamic chucvu;
  dynamic tenphong;
  dynamic danhgia;
  dynamic luotdanhgia;
  dynamic maphong;
  dynamic makhoa;
  dynamic tenkhoa;

  BacSiData({
    required this.mabs,
    required this.tenbs,
    required this.gioitinh,
    required this.sodienthoai,
    required this.email,
    required this.hinhdaidien,
    required this.trinhdo,
    required this.chuyenmon,
    required this.chuyenkhoa,
    required this.chucvu,
    required this.tenphong,
    required this.danhgia,
    required this.luotdanhgia,
    required this.maphong,
    required this.makhoa,
    required this.tenkhoa,
  });

  factory BacSiData.fromJson(Map<String, dynamic> json) => BacSiData(
        mabs: json["mabs"],
        tenbs: json["tenbs"],
        gioitinh: json["gioitinh"],
        sodienthoai: json["sodienthoai"],
        email: json["email"],
        hinhdaidien: json["hinhdaidien"],
        trinhdo: json["trinhdo"],
        chuyenmon: json["chuyenmon"],
        chuyenkhoa: json["chuyenkhoa"],
        chucvu: json["chucvu"],
        tenphong: json["tenphong"],
        danhgia: json["danhgia"],
        luotdanhgia: json["luotdanhgia"],
        maphong: json["maphong"],
        makhoa: json["makhoa"],
        tenkhoa: json["tenkhoa"],
      );

  Map<String, dynamic> toJson() => {
        "mabs": mabs,
        "tenbs": tenbs,
        "gioitinh": gioitinh,
        "sodienthoai": sodienthoai,
        "email": email,
        "hinhdaidien": hinhdaidien,
        "trinhdo": trinhdo,
        "chuyenmon": chuyenmon,
        "chuyenkhoa": chuyenkhoa,
        "chucvu": chucvu,
        "tenphong": tenphong,
        "danhgia": danhgia,
        "luotdanhgia": luotdanhgia,
        "maphong": maphong,
        "makhoa": makhoa,
        "tenkhoa": tenkhoa,
      };
}

class OutputDanhGia {
  String mabs;
  double danhgia;
  int luotdanhgia;

  OutputDanhGia({
    required this.mabs,
    required this.danhgia,
    required this.luotdanhgia,
  });

  factory OutputDanhGia.fromJson(Map<String, dynamic> json) => OutputDanhGia(
        mabs: json["mabs"],
        danhgia: json["danhgia"]?.toDouble(),
        luotdanhgia: json["luotdanhgia"],
      );

  Map<String, dynamic> toJson() => {
        "mabs": mabs,
        "danhgia": danhgia,
        "luotdanhgia": luotdanhgia,
      };
}
