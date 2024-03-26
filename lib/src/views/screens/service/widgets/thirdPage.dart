import 'dart:convert';

import 'package:app/src/controllers/serviceController/DangKyKhamController.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/service/provider/BHYT.dart';
import 'package:app/src/views/screens/service/provider/CCCD.dart';
import 'package:app/src/views/screens/service/provider/class.dart';
import 'package:app/src/views/screens/service/provider/serviceProvider.dart';
import 'package:app/src/views/screens/service/widgets/goiKhamSK.dart';
import 'package:app/src/views/screens/service/widgets/scanQR_BHYT.dart';
import 'package:app/src/views/screens/service/widgets/scanQR_CCCD.dart';
import 'package:app/src/views/screens/service/widgets/nhapThuCong.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  CCCD? thongTinCC;
  BHYT? thongTinBH;
  String loaithe = '';
  DangKyKham? dangky;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ServiceProvider>(context);
    LichKham lichKham = provider.lichKham;
    return SingleChildScrollView(
      primary: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            color: myColor.withOpacity(.1),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            elevation: 0,
            shadowColor: Colors.black87,
            child: Container(
              // height: 100,
              padding: EdgeInsets.all(10),
              // child: Te,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        UniconsLine.building,
                        color: myColor,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "${lichKham.khoa.tenKhoa}",
                          style: TextStyle(color: myColor),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        UniconsLine.stethoscope,
                        color: myColor,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "${lichKham.bacSi.tenBacSi}",
                          style: TextStyle(color: myColor),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        UniconsLine.bed,
                        color: myColor,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "${lichKham.bacSi.phong.tenPhong}",
                          style: TextStyle(color: myColor),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        UniconsLine.calendar_alt,
                        color: myColor,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "${formatDateVi2(lichKham.ngayDangKy)}",
                          style: TextStyle(color: myColor),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        UniconsLine.clock,
                        color: myColor,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "${lichKham.gioKham}",
                          style: TextStyle(color: myColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          dangky == null
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: myColor),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'THÔNG TIN CÁ NHÂN',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Divider(
                              height: 1,
                              color: myColor,
                            ),
                          ),
                          Text('Họ tên: ${checkString(dangky?.hoten)}'),
                          Text('Ngày sinh: ${formatDate(dangky!.ngaysinh)}'),
                          Text('Loại thẻ: ${checkString(dangky?.loaithe)}'),
                          Text('Số thẻ: ${checkString(dangky?.sothe)}'),
                          thongTinCC == null
                              ? SizedBox()
                              : ExpansionTile(
                                  title: Row(
                                    children: [
                                      Icon(Icons.qr_code),
                                      Text(
                                        'CĂN CƯỚC CÔNG DÂN',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                  initiallyExpanded: false,
                                  childrenPadding: EdgeInsets.all(5),
                                  backgroundColor: myColor.withOpacity(.05),
                                  iconColor: myColor,
                                  textColor: myColor,
                                  collapsedShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  children: [viewCCCD(thongTinCC!)],
                                ),
                          thongTinBH == null
                              ? SizedBox()
                              : ExpansionTile(
                                  title: Row(
                                    children: [
                                      Icon(Icons.qr_code),
                                      Text(
                                        'BẢO HIỂM Y TẾ',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                  initiallyExpanded: false,
                                  childrenPadding: EdgeInsets.all(5),
                                  backgroundColor: myColor.withOpacity(.05),
                                  iconColor: myColor,
                                  textColor: myColor,
                                  collapsedShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  children: [viewBHYT(thongTinBH!)]),
                        ],
                      ),
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                provider.lichKham.loaiKham.loaiKham == "BHYT"
                    ? ExpansionTile(
                        initiallyExpanded: true,
                        childrenPadding: EdgeInsets.symmetric(vertical: 10),
                        title: Row(
                          children: [
                            Icon(
                              UniconsLine.qrcode_scan,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text("Nhập thông tin bằng mã quét mã QR"),
                            ),
                          ],
                        ),
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: MyButton(
                                  padding: EdgeInsets.all(10),
                                  label: "Quét căn cước",
                                  onPressed: () async {
                                    var cccd = Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ScanQR_CCCD(),
                                    ));

                                    cccd.then((value) {
                                      if (value != null) {
                                        setState(() {
                                          loaithe = 'CCCD';
                                          thongTinCC =
                                              CCCD.fromJson(jsonDecode(value));
                                        });
                                        if (thongTinCC != null) {
                                          var dk = DangKyKham(
                                            loaithe: 'CCCD',
                                            sothe: '${thongTinCC?.soCCCD}',
                                            hoten: '${thongTinCC?.ten}',
                                            ngaysinh: thongTinCC!.ngaySinh,
                                            qrcode: '${thongTinCC?.qrcode}',
                                          );
                                          setState(() {
                                            dangky = dk;
                                          });
                                          provider.updateDangKyKham(dk);
                                        }
                                      }
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: MyButton(
                                  enabled: lichKham.loaiKham.loaiKham == 'BHYT',
                                  padding: EdgeInsets.all(10),
                                  label: "Quét BHYT",
                                  onPressed: () async {
                                    var bhyt = Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ScanQR_BHYT(),
                                    ));

                                    bhyt.then((value) {
                                      if (value != null) {
                                        setState(() {
                                          loaithe = 'BHYT';
                                          thongTinBH =
                                              BHYT.fromJson(jsonDecode(value));
                                        });
                                        if (thongTinBH != null) {
                                          var dk = DangKyKham(
                                            loaithe: 'BHYT',
                                            sothe: '${thongTinBH?.maThe}',
                                            hoten: '${thongTinBH?.hoTen}',
                                            ngaysinh: thongTinBH!.ngaySinh,
                                            qrcode: '${thongTinBH?.qrcode}',
                                          );
                                          setState(() {
                                            dangky = dk;
                                          });
                                          provider.updateDangKyKham(dk);
                                        }
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : SizedBox(),
                provider.lichKham.loaiKham.loaiKham == "KSK"
                    ? GoiKhamSK(
                        ngaykham: provider.lichKham.ngayDangKy,
                        giokham: provider.lichKham.gioKham,
                      )
                    : MyButton(
                        width: screen(context).width,
                        label: "Nhập thủ công",
                        padding: EdgeInsets.all(10),
                        color: myColor.withOpacity(.1),
                        textColor: myColor,
                        onPressed: () {
                          var dialog = showDialog(
                            context: context,
                            builder: (context) => NhapThuCong(
                              loaikham: lichKham.loaiKham.loaiKham,
                            ),
                          );
                          dialog.then((value) {
                            if (value != null) {
                              setState(() {
                                dangky = DangKyKham.fromJson(value);
                              });
                              provider.updateDangKyKham(dangky!);
                            }
                          });
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  viewCCCD(CCCD data) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: myColor),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Divider(
                height: 1,
                color: myColor,
              ),
            ),
            Text('Số CCCD: ${data.soCCCD}'),
            //Text('Số CMND: ${thongTinCC?.soCCCD}'),
            Text('Họ tên: ${data.ten}'),
            Text('Ngày sinh: ${formatDate(data.ngaySinh)}'),
            Text('Giới tính: ${data.gioiTinh}'),
            Text('Địa chỉ: ${data.diaChi}'),
            Text('Ngày cấp: ${formatDate(data.ngayCap)}'),
          ],
        ),
      ),
    );
  }

  viewBHYT(BHYT data) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: myColor),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Divider(
                height: 1,
                color: myColor,
              ),
            ),
            Text('Mã số: ${thongTinBH?.maThe}'),
            Text('Họ tên: ${thongTinBH?.hoTen}'),
            Text('Ngày sinh: ${formatDate(thongTinBH!.ngaySinh)}'),
            Text('Giới tính: ${thongTinBH?.gioiTinh}'),
            Text('Địa chỉ: ${thongTinBH?.diaChi}'),
            Text('Ngày cấp: ${formatDate(thongTinBH!.ngayCap)}'),
            Text('Nơi cấp: ${thongTinBH!.noiCapDoithe}'),
            // Text(
            //     'Thời hạn: ${formatDate(thongTinBH!.hsdTuNgay)}${thongTinBH!.hsdDenNgay == '-' ? '' : ' - ' + formatDate(thongTinBH!.hsdDenNgay)}'),
          ],
        ),
      ),
    );
  }
}
