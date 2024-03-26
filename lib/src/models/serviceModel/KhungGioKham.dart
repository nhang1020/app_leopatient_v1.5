// To parse this JSON data, do
//
//     final KhungGioKham = KhungGioKhamFromJson(jsonString);

import 'dart:convert';

KhungGioKham KhungGioKhamFromJson(String str) => KhungGioKham.fromJson(json.decode(str));

String KhungGioKhamToJson(KhungGioKham data) => json.encode(data.toJson());

class KhungGioKham {
    bool success;
    List<KhungGioKhamData> data;
    String message;

    KhungGioKham({
        required this.success,
        required this.data,
        required this.message,
    });

    factory KhungGioKham.fromJson(Map<String, dynamic> json) => KhungGioKham(
        success: json["success"],
        data: List<KhungGioKhamData>.from(json["data"].map((x) => KhungGioKhamData.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class KhungGioKhamData {
    String loaikham;
    String buoikham;
    DateTime ngaydangky;
    String makhoa;
    String maphong;
    String mabs;
    String gio;
    bool dangky;

    KhungGioKhamData({
        required this.loaikham,
        required this.buoikham,
        required this.ngaydangky,
        required this.makhoa,
        required this.maphong,
        required this.mabs,
        required this.gio,
        required this.dangky,
    });

    factory KhungGioKhamData.fromJson(Map<String, dynamic> json) => KhungGioKhamData(
        loaikham: json["loaikham"],
        buoikham: json["buoikham"],
        ngaydangky: DateTime.parse(json["ngaydangky"]),
        makhoa: json["makhoa"],
        maphong: json["maphong"],
        mabs: json["mabs"],
        gio: json["gio"],
        dangky: json["dangky"],
    );

    Map<String, dynamic> toJson() => {
        "loaikham": loaikham,
        "buoikham": buoikham,
        "ngaydangky": "${ngaydangky.year.toString().padLeft(4, '0')}-${ngaydangky.month.toString().padLeft(2, '0')}-${ngaydangky.day.toString().padLeft(2, '0')}",
        "makhoa": makhoa,
        "maphong": maphong,
        "mabs": mabs,
        "gio": gio,
        "dangky": dangky,
    };
}
