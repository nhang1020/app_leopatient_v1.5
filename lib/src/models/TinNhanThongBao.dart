// To parse this JSON data, do
//
//     final tinNhanThongBao = tinNhanThongBaoFromJson(jsonString);

import 'dart:convert';

TinNhanThongBao tinNhanThongBaoFromJson(String str) =>
    TinNhanThongBao.fromJson(json.decode(str));

String tinNhanThongBaoToJson(TinNhanThongBao data) =>
    json.encode(data.toJson());

class TinNhanThongBao {
  DateTime thoigian;
  String tieude;
  String noidung;
  dynamic link;
  dynamic hinhanh;
  bool? daxem;

  TinNhanThongBao(
      {required this.thoigian,
      required this.tieude,
      required this.noidung,
      this.link,
      this.hinhanh,
      this.daxem});

  factory TinNhanThongBao.fromJson(Map<String, dynamic> json) =>
      TinNhanThongBao(
        thoigian: DateTime.parse(json["thoigian"]),
        tieude: json["tieude"],
        noidung: json["noidung"],
        link: json["link"],
        hinhanh: json["hinhanh"],
        daxem: json["daxem"],
      );

  Map<String, dynamic> toJson() => {
        "thoigian": thoigian.toIso8601String(),
        "tieude": tieude,
        "noidung": noidung,
        "link": link,
        "hinhanh": hinhanh,
        "daxem": daxem,
      };
}
