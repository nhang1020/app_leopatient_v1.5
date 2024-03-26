class Khoa {
  final String maKhoa;
  final String tenKhoa;

  Khoa({required this.maKhoa, required this.tenKhoa});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Khoa &&
          runtimeType == other.runtimeType &&
          maKhoa == other.maKhoa &&
          tenKhoa == other.tenKhoa;

  @override
  int get hashCode => maKhoa.hashCode ^ tenKhoa.hashCode;
}

class LoaiKham {
  final String loaiKham;
  final String tenLoai;

  LoaiKham({required this.loaiKham, required this.tenLoai});
}

class BacSi {
  final String maBacSi;
  final String tenBacSi;
  final Phong phong;
  final double? danhGia;
  final int? luotDanhGia;
  final dynamic dongia;
  BacSi({
    required this.maBacSi,
    required this.tenBacSi,
    required this.phong,
    this.danhGia,
    this.luotDanhGia,
    this.dongia = 0,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BacSi &&
          runtimeType == other.runtimeType &&
          maBacSi == other.maBacSi &&
          tenBacSi == other.tenBacSi;

  @override
  int get hashCode => maBacSi.hashCode ^ tenBacSi.hashCode;
}

class Phong {
  final String maPhong;
  final String tenPhong;

  Phong({required this.maPhong, required this.tenPhong});
}

class LichKham {
  final LoaiKham loaiKham;
  final DateTime ngayDangKy;
  final Khoa khoa;
  final BacSi bacSi;
  final String? gioKham;
  LichKham({
    required this.loaiKham,
    required this.ngayDangKy,
    required this.khoa,
    required this.bacSi,
    this.gioKham,
  });
}

LichKham newlichKham = LichKham(
  loaiKham: LoaiKham(loaiKham: "", tenLoai: ""),
  ngayDangKy: DateTime(0),
  khoa: Khoa(maKhoa: "", tenKhoa: ""),
  bacSi:
      BacSi(maBacSi: "", tenBacSi: "", phong: Phong(maPhong: "", tenPhong: "")),
  gioKham: "",
);
