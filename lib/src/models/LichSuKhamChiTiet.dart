// To parse this JSON data, do
//
//     final lichSuKhamChiTiet = lichSuKhamChiTietFromJson(jsonString);

import 'dart:convert';

LichSuKhamChiTiet lichSuKhamChiTietFromJson(String str) =>
    LichSuKhamChiTiet.fromJson(json.decode(str));

String lichSuKhamChiTietToJson(LichSuKhamChiTiet data) =>
    json.encode(data.toJson());

class LichSuKhamChiTiet {
  bool success;
  LskChiTietData data;
  String message;

  LichSuKhamChiTiet({
    required this.success,
    required this.data,
    required this.message,
  });

  factory LichSuKhamChiTiet.fromJson(Map<String, dynamic> json) =>
      LichSuKhamChiTiet(
        success: json["success"],
        data: LskChiTietData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class LskChiTietData {
  List<Dvtk> dvtk;
  List<Thuoc> thuoc;

  LskChiTietData({
    required this.dvtk,
    required this.thuoc,
  });

  factory LskChiTietData.fromJson(Map<String, dynamic> json) => LskChiTietData(
        dvtk: List<Dvtk>.from(json["dvtk"].map((x) => Dvtk.fromJson(x))),
        thuoc: List<Thuoc>.from(json["thuoc"].map((x) => Thuoc.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dvtk": List<dynamic>.from(dvtk.map((x) => x.toJson())),
        "thuoc": List<dynamic>.from(thuoc.map((x) => x.toJson())),
      };
}

class Dvtk {
  String mahs;
  DateTime ngayChidinh;
  dynamic tendichvu;
  dynamic bacsiChidinh;
  dynamic khoaChidinh;
  dynamic khoaTrakq;
  DateTime ngayKetqua;
  dynamic nguoiTrakq;
  int tinhtrangSudung;
  dynamic manhomdv;
  dynamic tennhomdv;
  dynamic manhomdvCha;
  dynamic machidinhDvct;
  dynamic machidinhDvctKq;

  Dvtk({
    required this.mahs,
    required this.ngayChidinh,
    required this.tendichvu,
    required this.bacsiChidinh,
    required this.khoaChidinh,
    required this.khoaTrakq,
    required this.ngayKetqua,
    required this.nguoiTrakq,
    required this.tinhtrangSudung,
    required this.manhomdv,
    required this.tennhomdv,
    required this.manhomdvCha,
    required this.machidinhDvct,
    required this.machidinhDvctKq,
  });

  factory Dvtk.fromJson(Map<String, dynamic> json) => Dvtk(
        mahs: json["mahs"],
        ngayChidinh: DateTime.parse(json["ngay_chidinh"]),
        tendichvu: json["tendichvu"],
        bacsiChidinh: json["bacsi_chidinh"],
        khoaChidinh: json["khoa_chidinh"],
        khoaTrakq: json["khoa_trakq"],
        ngayKetqua: DateTime.parse(json["ngay_ketqua"]),
        nguoiTrakq: json["nguoi_trakq"],
        tinhtrangSudung: json["tinhtrang_sudung"],
        manhomdv: json["manhomdv"],
        tennhomdv: json["tennhomdv"],
        manhomdvCha: json["manhomdv_cha"],
        machidinhDvct: json["machidinh_dvct"],
        machidinhDvctKq: json["machidinh_dvct_kq"],
      );

  Map<String, dynamic> toJson() => {
        "mahs": mahs,
        "ngay_chidinh": ngayChidinh.toIso8601String(),
        "tendichvu": tendichvu,
        "bacsi_chidinh": bacsiChidinh,
        "khoa_chidinh": khoaChidinh,
        "khoa_trakq": khoaTrakq,
        "ngay_ketqua": ngayKetqua.toIso8601String(),
        "nguoi_trakq": nguoiTrakq,
        "tinhtrang_sudung": tinhtrangSudung,
        "manhomdv": manhomdv,
        "tennhomdv": tennhomdv,
        "manhomdv_cha": manhomdvCha,
        "machidinh_dvct": machidinhDvct,
        "machidinh_dvct_kq": machidinhDvctKq,
      };
}

class Thuoc {
  DateTime ngay;
  String tenbs;
  dynamic macs;
  dynamic tenthuoc;
  dynamic hamluong;
  dynamic donvi;
  dynamic soluong;
  dynamic cachdung;

  Thuoc({
    required this.ngay,
    required this.tenbs,
    required this.macs,
    required this.tenthuoc,
    required this.hamluong,
    required this.donvi,
    required this.soluong,
    required this.cachdung,
  });

  factory Thuoc.fromJson(Map<String, dynamic> json) => Thuoc(
        ngay: DateTime.parse(json["ngay"]),
        tenbs: json["tenbs"],
        macs: json["macs"],
        tenthuoc: json["tenthuoc"],
        hamluong: json["hamluong"],
        donvi: json["donvi"],
        soluong: json["soluong"],
        cachdung: json["cachdung"],
      );

  Map<String, dynamic> toJson() => {
        "ngay": ngay.toIso8601String(),
        "tenbs": tenbs,
        "macs": macs,
        "tenthuoc": tenthuoc,
        "hamluong": hamluong,
        "donvi": donvi,
        "soluong": soluong,
        "cachdung": cachdung,
      };
}
