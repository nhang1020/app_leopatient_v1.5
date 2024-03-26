// To parse this JSON data, do
//
//     final lichSuKham = lichSuKhamFromJson(jsonString);

import 'dart:convert';

LichSuKham lichSuKhamFromJson(String str) =>
    LichSuKham.fromJson(json.decode(str));

String lichSuKhamToJson(LichSuKham data) => json.encode(data.toJson());

class LichSuKham {
  bool success;
  List<LichSuKhamData> data;
  String message;

  LichSuKham({
    required this.success,
    required this.data,
    required this.message,
  });

  factory LichSuKham.fromJson(Map<String, dynamic> json) => LichSuKham(
        success: json["success"],
        data: List<LichSuKhamData>.from(
            json["data"].map((x) => LichSuKhamData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class LichSuKhamData {
  String mahs;
  String sohoso;
  DateTime ngayvaovien;
  DateTime ngaykham;
  DateTime ngayravien;
  String loaikcb;
  String chandoanIcd;
  String chandoan;

  LichSuKhamData({
    required this.mahs,
    required this.sohoso,
    required this.ngayvaovien,
    required this.ngaykham,
    required this.ngayravien,
    required this.loaikcb,
    required this.chandoanIcd,
    required this.chandoan,
  });

  factory LichSuKhamData.fromJson(Map<String, dynamic> json) => LichSuKhamData(
        mahs: json["mahs"],
        sohoso: json["sohoso"],
        ngayvaovien: DateTime.parse(json["ngayvaovien"]),
        ngaykham: DateTime.parse(json["ngaykham"]),
        ngayravien: DateTime.parse(json["ngayravien"]),
        loaikcb: json["loaikcb"],
        chandoanIcd: json["chandoan_icd"],
        chandoan: json["chandoan"],
      );

  Map<String, dynamic> toJson() => {
        "mahs": mahs,
        "sohoso": sohoso,
        "ngayvaovien": ngayvaovien.toIso8601String(),
        "ngaykham": ngaykham.toIso8601String(),
        "ngayravien": ngayravien.toIso8601String(),
        "loaikcb": loaikcb,
        "chandoan_icd": chandoanIcd,
        "chandoan": chandoan,
      };
}
