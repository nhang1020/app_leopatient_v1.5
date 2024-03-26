import 'package:app/src/controllers/serviceController/DangKyKhamController.dart';
import 'package:app/src/views/screens/service/provider/class.dart';
import 'package:flutter/material.dart';

class ServiceProvider extends ChangeNotifier {
  LichKham _lichKham = newlichKham;

  LichKham get lichKham => _lichKham;

  DangKyKham? _dangKyKham;
  DangKyKham? get dangKyKham => _dangKyKham;

  String? _maGoiKSK;
  String? get maGoiKSK => _maGoiKSK;

  void setGioKham(String gioKham) {
    _lichKham = LichKham(
        loaiKham: lichKham.loaiKham,
        ngayDangKy: lichKham.ngayDangKy,
        khoa: lichKham.khoa,
        bacSi: lichKham.bacSi,
        gioKham: gioKham);
    notifyListeners();
  }

  void updateDangKyKham(DangKyKham dk) {
    _dangKyKham = dk;
    notifyListeners();
  }

  void updateMaGoiKSK(String? ma) {
    _maGoiKSK = ma;
    notifyListeners();
  }

  void updateLicKham(LichKham lichKham) {
    _lichKham = lichKham;
    notifyListeners();
  }

  bool enabled(int page) {
    if (page == 0) {
      return _lichKham.bacSi.maBacSi != "";
    }
    if (page == 1) {
      return lichKham.gioKham != "";
    }
    if (page == 2) {
      return dangKyKham != null || _maGoiKSK != null;
    }
    return false;
  }
}
