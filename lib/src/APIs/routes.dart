import 'package:flutter/material.dart';

class APIs extends ChangeNotifier {
  String _server = 'http://14.232.236.62:9090/api';
  String get server => _server;
  updateServer(String newServer) {
    _server = newServer;
    notifyListeners();
  }

  String Url_DangNhap() {
    return '$_server/login';
  }

  String Url_User() {
    return '$_server/user';
  }

  String Url_LichSuKham() {
    return '$_server/lich-su-kcb';
  }

  String Url_LichSuKhamChiTiet() {
    return '$_server/lich-su-kcb-chi-tiet';
  }

  String Url_XemKetQuaCls() {
    return '$_server/xem-ket-qua-cls';
  }

  String Url_CapNhatAnhDaiDien() {
    return '$_server/update-avatar';
  }

  String Url_DoiMatKhau() {
    return '$_server/change-password';
  }

  String Url_DanhSachBacSi() {
    return '$_server/danh-sach-bac-si';
  }

  String Url_DanhGiaBacSi() {
    return '$_server/danh-gia-bac-si';
  }

  String Url_DanhSachKhoa() {
    return '$_server/danh-sach-khoa-kham';
  }

  String Url_DanhSachPhong() {
    return '$_server/danh-sach-phong-kham';
  }

  String Url_MegsLuuToken() {
    return '$_server/megs-luu-token';
  }

  String Url_DanhSachThongBao() {
    return '$_server/megs-noi-dung-thong-bao';
  }

  //Dang ky Dich Vu
  String Url_DichVuKham() {
    return '$_server/kcb-loai-kham';
  }

  String Url_LichDichVuKham() {
    return '$_server/kcb-lich-kham';
  }

  String Url_KhungGioKham() {
    return '$_server/kcb-gio-kham';
  }

  String Url_DangKyKham() {
    return '$_server/kcb-dang-ky';
  }

  String Url_XacNhanThanhToan() {
    return '$_server/kcb-xac-nhan-phuong-thuc-thanh-toan';
  }

  String Url_GoiKhamSucKhoe() {
    return '$_server/ksk-goi-kham';
  }

  String Url_DangKyKhamSucKhoe() {
    return '$_server/ksk-dang-ky';
  }
}
