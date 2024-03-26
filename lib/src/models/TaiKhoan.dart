import 'dart:convert';

TaiKhoan TaiKhoanFromJson(String str) => TaiKhoan.fromJson(json.decode(str));

String TaiKhoanToJson(TaiKhoan data) => json.encode(data.toJson());

class TaiKhoan {
  bool success;
  TaiKhoanData data;
  String message;

  TaiKhoan({
    required this.success,
    required this.data,
    required this.message,
  });

  factory TaiKhoan.fromJson(Map<String, dynamic> json) => TaiKhoan(
        success: json["success"],
        data: TaiKhoanData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class TaiKhoanData {
  dynamic token;
  int idkh;
  dynamic hoten;
  dynamic gioitinh;
  DateTime ngaysinh;
  dynamic cccd;
  dynamic dienthoai;
  dynamic diachi;
  dynamic mabhxh;
  dynamic nghenghiep;
  dynamic ghichu;
  dynamic avatar;
  int doimatkhau;

  TaiKhoanData({
    required this.token,
    required this.idkh,
    required this.hoten,
    required this.gioitinh,
    required this.ngaysinh,
    required this.cccd,
    required this.dienthoai,
    required this.diachi,
    required this.mabhxh,
    required this.nghenghiep,
    required this.ghichu,
    required this.avatar,
    required this.doimatkhau,
  });

  factory TaiKhoanData.fromJson(Map<String, dynamic> json) => TaiKhoanData(
        token: json["token"],
        idkh: json["idkh"],
        hoten: json["hoten"],
        gioitinh: json["gioitinh"],
        ngaysinh: DateTime.parse(json["ngaysinh"]),
        cccd: json["cccd"],
        dienthoai: json["dienthoai"],
        diachi: json["diachi"],
        mabhxh: json["mabhxh"],
        nghenghiep: json["nghenghiep"],
        ghichu: json["ghichu"],
        avatar: json["avatar"],
        doimatkhau: json["doimatkhau"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "idkh": idkh,
        "hoten": hoten,
        "gioitinh": gioitinh,
        "ngaysinh":
            "${ngaysinh.year.toString().padLeft(4, '0')}-${ngaysinh.month.toString().padLeft(2, '0')}-${ngaysinh.day.toString().padLeft(2, '0')}",
        "cccd": cccd,
        "dienthoai": dienthoai,
        "diachi": diachi,
        "mabhxh": mabhxh,
        "nghenghiep": nghenghiep,
        "ghichu": ghichu,
        "avatar": avatar,
        "doimatkhau": doimatkhau,
      };
}
