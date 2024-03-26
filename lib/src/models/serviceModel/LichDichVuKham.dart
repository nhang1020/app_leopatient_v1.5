// To parse this JSON data, do
//
//     final LichDichVuKham = LichDichVuKhamFromJson(jsonString);

import 'dart:convert';

LichDichVuKham LichDichVuKhamFromJson(String str) =>
    LichDichVuKham.fromJson(json.decode(str));

String LichDichVuKhamToJson(LichDichVuKham data) => json.encode(data.toJson());

class LichDichVuKham {
  bool success;
  List<LichDichVuKhamData> data;
  String message;

  LichDichVuKham({
    required this.success,
    required this.data,
    required this.message,
  });

  factory LichDichVuKham.fromJson(Map<String, dynamic> json) => LichDichVuKham(
        success: json["success"],
        data: List<LichDichVuKhamData>.from(
            json["data"].map((x) => LichDichVuKhamData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class LichDichVuKhamData {
  DateTime ngaykham;
  dynamic buoikham;
  dynamic makhoa;
  dynamic tenkhoa;
  dynamic maphong;
  dynamic tenphong;
  dynamic mabs;
  dynamic tenbs;
  dynamic danhgia;
  dynamic luotdanhgia;
  dynamic madv;
  dynamic tendichvu;
  int dongiaBv;
  int giaBhyt;
//
  LichDichVuKhamData({
    required this.ngaykham,
    this.buoikham,
    this.makhoa,
    this.tenkhoa,
    this.maphong,
    this.tenphong,
    this.mabs,
    this.tenbs,
    this.danhgia,
    this.luotdanhgia,
    this.madv,
    this.tendichvu,
    required this.dongiaBv,
    required this.giaBhyt,
  });

  factory LichDichVuKhamData.fromJson(Map<String, dynamic> json) =>
      LichDichVuKhamData(
        ngaykham: DateTime.parse(json["ngaykham"]),
        buoikham: json["buoikham"],
        makhoa: json["makhoa"],
        tenkhoa: json["tenkhoa"],
        maphong: json["maphong"],
        tenphong: json["tenphong"],
        mabs: json["mabs"],
        tenbs: json["tenbs"],
        danhgia: json["danhgia"]?.toDouble(),
        luotdanhgia: json["luotdanhgia"],
        madv: json["madv"],
        tendichvu: json["tendichvu"],
        dongiaBv: json["dongia_bv"],
        giaBhyt: json["gia_bhyt"],
      );

  Map<String, dynamic> toJson() => {
        "ngaykham":
            "${ngaykham.year.toString().padLeft(4, '0')}-${ngaykham.month.toString().padLeft(2, '0')}-${ngaykham.day.toString().padLeft(2, '0')}",
        "buoikham": buoikham,
        "makhoa": makhoa,
        "tenkhoa": tenkhoa,
        "maphong": maphong,
        "tenphong": tenphong,
        "mabs": mabs,
        "tenbs": tenbs,
        "danhgia": danhgia,
        "luotdanhgia": luotdanhgia,
        "madv": madv,
        "tendichvu": tendichvu,
        "dongia_bv": dongiaBv,
        "gia_bhyt": giaBhyt,
      };
}
