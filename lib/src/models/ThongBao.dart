// To parse this JSON data, do
//
//     final thongBao = thongBaoFromJson(jsonString);

import 'dart:convert';

ThongBao thongBaoFromJson(String str) => ThongBao.fromJson(json.decode(str));

String thongBaoToJson(ThongBao data) => json.encode(data.toJson());

class ThongBao {
    bool success;
    List<ThongBaoData> data;
    String message;

    ThongBao({
        required this.success,
        required this.data,
        required this.message,
    });

    factory ThongBao.fromJson(Map<String, dynamic> json) => ThongBao(
        success: json["success"],
        data: List<ThongBaoData>.from(json["data"].map((x) => ThongBaoData.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class ThongBaoData {
    DateTime ngaythongbao;
    DateTime? ngayhen;
    String tieude;
    String noidung;

    ThongBaoData({
        required this.ngaythongbao,
        required this.ngayhen,
        required this.tieude,
        required this.noidung,
    });

    factory ThongBaoData.fromJson(Map<String, dynamic> json) => ThongBaoData(
        ngaythongbao: DateTime.parse(json["ngaythongbao"]),
        ngayhen: json["ngayhen"] == null ? null : DateTime.parse(json["ngayhen"]),
        tieude: json["tieude"],
        noidung: json["noidung"],
    );

    Map<String, dynamic> toJson() => {
        "ngaythongbao": ngaythongbao.toIso8601String(),
        "ngayhen": ngayhen?.toIso8601String(),
        "tieude": tieude,
        "noidung": noidung,
    };
}
