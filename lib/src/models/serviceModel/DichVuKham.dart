// To parse this JSON data, do
//
//     final DichVuKham = DichVuKhamFromJson(jsonString);

import 'dart:convert';

DichVuKham DichVuKhamFromJson(String str) =>
    DichVuKham.fromJson(json.decode(str));

String DichVuKhamToJson(DichVuKham data) => json.encode(data.toJson());

class DichVuKham {
  bool success;
  List<DichVuKhamData> data;
  String message;

  DichVuKham({
    required this.success,
    required this.data,
    required this.message,
  });

  factory DichVuKham.fromJson(Map<String, dynamic> json) => DichVuKham(
        success: json["success"],
        data: List<DichVuKhamData>.from(
            json["data"].map((x) => DichVuKhamData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class DichVuKhamData {
  String loaikham;
  String tenloai;
  int thoigian;
  DateTime ngaybd;
  DateTime ngaykt;

  DichVuKhamData({
    required this.loaikham,
    required this.tenloai,
    required this.thoigian,
    required this.ngaybd,
    required this.ngaykt,
  });

  factory DichVuKhamData.fromJson(Map<String, dynamic> json) => DichVuKhamData(
        loaikham: json["loaikham"],
        tenloai: json["tenloai"],
        thoigian: json["thoigian"],
        ngaybd: DateTime.parse(json["ngaybd"]),
        ngaykt: DateTime.parse(json["ngaykt"]),
      );

  Map<String, dynamic> toJson() => {
        "loaikham": loaikham,
        "tenloai": tenloai,
        "thoigian": thoigian,
        "ngaybd":
            "${ngaybd.year.toString().padLeft(4, '0')}-${ngaybd.month.toString().padLeft(2, '0')}-${ngaybd.day.toString().padLeft(2, '0')}",
        "ngaykt":
            "${ngaykt.year.toString().padLeft(4, '0')}-${ngaykt.month.toString().padLeft(2, '0')}-${ngaykt.day.toString().padLeft(2, '0')}",
      };
}

GoiKhamSk goiKhamSkFromJson(String str) => GoiKhamSk.fromJson(json.decode(str));

String goiKhamSkToJson(GoiKhamSk data) => json.encode(data.toJson());

class GoiKhamSk {
  bool success;
  List<GoiKhamSkChiTiet> data;
  String message;

  GoiKhamSk({
    required this.success,
    required this.data,
    required this.message,
  });

  factory GoiKhamSk.fromJson(Map<String, dynamic> json) => GoiKhamSk(
        success: json["success"],
        data: List<GoiKhamSkChiTiet>.from(
            json["data"].map((x) => GoiKhamSkChiTiet.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class GoiKhamSkChiTiet {
  dynamic magoidv;
  dynamic tengoi;
  dynamic tongtien;
  List<ChiTietGoiKSK> chitiet;

  GoiKhamSkChiTiet({
    required this.magoidv,
    required this.tengoi,
    required this.tongtien,
    required this.chitiet,
  });

  factory GoiKhamSkChiTiet.fromJson(Map<String, dynamic> json) =>
      GoiKhamSkChiTiet(
        magoidv: json["magoidv"],
        tengoi: json["tengoi"],
        tongtien: json["tongtien"],
        chitiet: List<ChiTietGoiKSK>.from(
            json["chitiet"].map((x) => ChiTietGoiKSK.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "magoidv": magoidv,
        "tengoi": tengoi,
        "tongtien": tongtien,
        "chitiet": List<dynamic>.from(chitiet.map((x) => x.toJson())),
      };
}

class ChiTietGoiKSK {
  dynamic madv;
  dynamic tendichvu;
  dynamic dvt;
  dynamic soluong;
  dynamic dongiaBv;

  ChiTietGoiKSK({
    required this.madv,
    required this.tendichvu,
    required this.dvt,
    required this.soluong,
    required this.dongiaBv,
  });

  factory ChiTietGoiKSK.fromJson(Map<String, dynamic> json) => ChiTietGoiKSK(
        madv: json["madv"],
        tendichvu: json["tendichvu"],
        dvt: json["dvt"],
        soluong: json["soluong"],
        dongiaBv: json["dongia_bv"],
      );

  Map<String, dynamic> toJson() => {
        "madv": madv,
        "tendichvu": tendichvu,
        "dvt": dvt,
        "soluong": soluong,
        "dongia_bv": dongiaBv,
      };
}
