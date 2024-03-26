import 'package:app/src/controllers/LichSuKhamChiTietController.dart';
import 'package:app/src/controllers/XemKetQuaClsController.dart';
import 'package:app/src/models/LichSuKhamChiTiet.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/test.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:app/src/views/widgets/emptyPage.dart';
import 'package:app/src/views/widgets/loadingPage.dart';
import 'package:app/src/views/widgets/rowData.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class HistoryDetail_screen extends StatefulWidget {
  int idkh;
  String mahs;
  DateTime ngaykham;
  HistoryDetail_screen(
      {super.key,
      required this.idkh,
      required this.mahs,
      required this.ngaykham});

  @override
  State<HistoryDetail_screen> createState() => _HistoryDetail_screenState();
}

class _HistoryDetail_screenState extends State<HistoryDetail_screen> {
  LichSuKhamChiTietController _chiTietController =
      LichSuKhamChiTietController();
  LskChiTietData _lskChiTietData = LskChiTietData(dvtk: [], thuoc: []);
  bool loading = false;
  late InAppWebViewController inApp;
  XemKetQuaClsController _ketQuaClsController = XemKetQuaClsController();
  List<DateTime> _dateThuoc = [];
  List<DateTime> _dateDv = [];
  loadData() async {
    loading = true;
    try {
      _lskChiTietData = await _chiTietController.getLichSuKham(
          widget.idkh.toString(), widget.mahs);

      for (var item in _lskChiTietData.thuoc) {
        _dateThuoc
            .add(DateTime(item.ngay.year, item.ngay.month, item.ngay.day));
      }
      _dateThuoc = _dateThuoc.toSet().toList();

      for (var item in _lskChiTietData.dvtk) {
        _dateDv.add(DateTime(item.ngayChidinh.year, item.ngayChidinh.month,
            item.ngayChidinh.day));
      }
      _dateDv = _dateDv.toSet().toList();

      setState(() {
        _lskChiTietData;
        _dateThuoc;
        _dateDv;
      });
      print(_dateThuoc.toString());
    } catch (e) {
    } finally {
      loading = false;
    }
  }

  getLinkCls(String? machidinh_dvct) async {
    var mess = await _ketQuaClsController.getKetQuaCls(machidinh_dvct);
    if (mess.contains('http:/')) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Screen_XemKetQuaCls(Url: '${mess}'),
          ));
    } else {
      showMessage('${mess}');
    }
  }

  ssNgay(DateTime date1, DateTime date2) {
    if (date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day)
      return true;
    else
      return false;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: myColor,
          // title: Text(
          //   'Ngày ${formatDate(widget.ngaykham)}',
          //   style: TextStyle(color: Theme.of(context).cardColor),
          // ),
          iconTheme: IconThemeData(color: Theme.of(context).cardColor),
          bottom: TabBar(
            indicator: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                color: Theme.of(context).canvasColor),
            labelColor: myColor,
            unselectedLabelColor: Colors.white54,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.room_service),
                text: 'Dịch vụ khám',
              ),
              Tab(
                icon: Icon(Icons.medical_services),
                text: 'Thuốc',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              child: loading
                  ? Loading()
                  : _lskChiTietData.dvtk.length == 0
                      ? EmptyList()
                      : ListView(
                          children: <Widget>[
                            for (var ngay in _dateDv)
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Column(
                                  children: [
                                    DividerTitle(
                                      title: '${formatDateVi(ngay)}',
                                      dividerColor: Colors.grey.withOpacity(.4),
                                      thickness: 1,
                                      color: Colors.grey,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      icon: Icon(
                                        Icons.calendar_month,
                                        size: 15,
                                        color: myColor.withOpacity(.5),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            color: Colors.grey.withOpacity(.6),
                                          ),
                                        ),
                                      ),
                                      child: Wrap(
                                        children: [
                                          for (var dv in _lskChiTietData.dvtk)
                                            if (ssNgay(dv.ngayChidinh, ngay))
                                              Row(
                                                children: [
                                                  HistoryTime(dv.ngayChidinh),
                                                  Expanded(
                                                    child: viewDichVuKham(dv),
                                                  ),
                                                ],
                                              )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ],
                        ),
            ),
            Container(
              child: loading
                  ? Loading()
                  : _lskChiTietData.thuoc.length == 0
                      ? EmptyList()
                      : ListView(
                          children: <Widget>[
                            for (var ngay in _dateThuoc)
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    DividerTitle(
                                      title: '${formatDateVi(ngay)}',
                                      dividerColor: Colors.grey.withOpacity(.4),
                                      thickness: 1,
                                      color: Colors.grey,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      icon: Icon(
                                        Icons.calendar_month,
                                        size: 15,
                                        color: myColor.withOpacity(.5),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            color: Colors.grey.withOpacity(.6),
                                          ),
                                        ),
                                      ),
                                      child: Wrap(
                                        children: [
                                          for (var thuoc
                                              in _lskChiTietData.thuoc)
                                            if (ssNgay(thuoc.ngay, ngay))
                                              Row(
                                                children: [
                                                  HistoryTime(thuoc.ngay),
                                                  Expanded(
                                                    child: viewThuoc(thuoc),
                                                  ),
                                                ],
                                              )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: myColor,
          mini: false,
          onPressed: () {},
          child: Icon(Icons.sort_by_alpha),
        ),
      ),
    );
  }

  viewDichVuKham(Dvtk data) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                child: Container(
                  child: Column(
                    children: [
                      // Row(
                      //   children: [
                      //     Icon(Icons.date_range_outlined,
                      //         size: 20, color: myColor),
                      //     Expanded(
                      //         child: Text(
                      //             "   Kết quả: ${formatDate(data.ngayKetqua)}",
                      //             maxLines: 1,
                      //             overflow: TextOverflow.ellipsis)),
                      //   ],
                      // ),
                      // SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(UniconsLine.stethoscope,
                              size: 20, color: myColor),
                          Expanded(
                              child: Text("  ${data.bacsiChidinh}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(UniconsLine.building, size: 20, color: myColor),
                          Expanded(
                              child: Text("  ${data.khoaChidinh}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(UniconsLine.vertical_distribution_center,
                              size: 20, color: myColor),
                          Expanded(
                              child: Text("  ${data.tendichvu}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: data.machidinhDvct != null &&
                      data.machidinhDvct != '' &&
                      data.tinhtrangSudung == 1
                  ? true
                  : false,
              child: MyButton(
                icon: Icon(
                  UniconsLine.eye,
                  color: Theme.of(context).cardColor,
                ),
                label: "Xem kết quả",
                onPressed: () {
                  getLinkCls(data.machidinhDvct);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget HistoryTime(DateTime time) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: myColor.withOpacity(.1),
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(10),
            ),
          ),
          child: Text(
            "${DateFormat("hh:mm").format(time)}",
            style: TextStyle(color: myColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  showMessage(String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text(
            message,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  viewThuoc(Thuoc data) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  checkString(data.tenthuoc),
                  style: TextStyle(
                      color: myColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              children: [
                Icon(UniconsLine.stethoscope, size: 20, color: myColor),
                Expanded(
                    child: Text("  ${data.tenbs}",
                        maxLines: 1, overflow: TextOverflow.ellipsis)),
              ],
            ),
            Container(
              child: ExpansionTile(
                initiallyExpanded: false,
                childrenPadding: EdgeInsets.all(5),
                backgroundColor: myColor.withOpacity(.5),
                iconColor: myColor,
                textColor: myColor,
                collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(
                  "Thông tin thuốc: ",
                  style: TextStyle(fontSize: 14),
                ),
                children: [
                  LineData(
                      left: "Số lượng:",
                      right:
                          "${double.parse(data.soluong).toStringAsFixed(0)} (${checkString(data.donvi)})"),
                  LineData(left: 'Hàm lượng: ', right: "${data.hamluong}"),
                  LineData(
                      left: 'Cách dùng: ',
                      right: "${checkString(data.cachdung)}"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
