import 'package:app/src/models/LichSuKham.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/history/historyDetail_screen.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:app/src/views/widgets/circleIner.dart';
import 'package:app/src/views/widgets/emptyPage.dart';
import 'package:app/src/views/widgets/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';
import 'package:animations/animations.dart';

class HistoryMedical_Screen extends StatefulWidget {
  final int idkh;
  final List<LichSuKhamData> listLichSuKham;
  const HistoryMedical_Screen(
      {super.key, required this.idkh, required this.listLichSuKham});

  @override
  State<HistoryMedical_Screen> createState() => _HistoryMedical_ScreenState();
}

class _HistoryMedical_ScreenState extends State<HistoryMedical_Screen>
    with SingleTickerProviderStateMixin {
  List<LichSuKhamData> _listHistory = [];
  List<LichSuKhamData> _displayListHistory = [];
  bool loading = false;
  DateTime _firstDate = DateTime(2000);
  DateTime _lastDate = DateTime.now();
  bool isDesc = false;
  bool reLoad = false;
  DateTime ngayBatDau = DateTime.now();
  DateTime ngayKetThuc = DateTime.now();

  List<int> _lstNam = [];
  List<int> _lstThang = [];
  Map<int, int> _yearItemCount = {};
  loadData() {
    try {
      //426875
      //
      _listHistory = widget.listLichSuKham;
      getDSNgay(_listHistory);
      setState(() {
        _displayListHistory = _listHistory;
        if (_listHistory.isNotEmpty) {
          _firstDate = _listHistory[_listHistory.length - 1].ngaykham;
          _lastDate = _listHistory[0].ngaykham;
          ngayBatDau = _firstDate;
          ngayKetThuc = _lastDate;
        }
      });
    } catch (e) {}
  }

  getDSNgay(List<LichSuKhamData> lst) {
    _lstThang.clear();
    _lstNam.clear();
    for (var item in lst) {
      _lstThang.add(item.ngaykham.month);
      _lstNam.add(item.ngaykham.year);
    }
    _lstNam = _lstNam.toSet().toList();

    _lstThang = _lstThang.toSet().toList();
    _yearItemCount = countItemsPerYear(_lstNam, _listHistory);
  }

  ssNgay(DateTime date1, int month, int year) {
    if (date1.year == year && date1.month == month)
      return true;
    else
      return false;
  }

  String toLoaiKham(String text) {
    var lk = text.split('Khám');
    String loai = lk.last.trim();
    return loai[0].toUpperCase() + loai.substring(1);
  }

  Map<int, int> countItemsPerYear(List<int> years, List<LichSuKhamData> items) {
    Map<int, int> result = {};

    for (int year in years) {
      int count = items.where((item) => item.ngaykham.year == year).length;
      result[year] = count;
    }

    return result;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future selectRangDate() async {
    DateTimeRange? picked = await showDateRangePicker(
      initialDateRange: DateTimeRange(start: ngayBatDau, end: ngayKetThuc),
      context: context,
      firstDate: _firstDate,
      lastDate: _lastDate,
      saveText: 'Chọn',
      helpText: 'Chọn khoảng thời gian',
      switchToCalendarEntryModeIcon:
          Icon(Icons.calendar_month, color: Colors.white),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: DatePickerThemeData(),
            appBarTheme: AppBarTheme(backgroundColor: myColor),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        ngayBatDau = picked.start;
        ngayKetThuc = picked.end;
      });
      _displayListHistory = _listHistory
          .where((element) =>
              element.ngaykham.isAfter(ngayBatDau.add(Duration(days: -1))) &&
              element.ngaykham.isBefore(ngayKetThuc.add(Duration(days: 1))))
          .toList();
    }

    getDSNgay(_displayListHistory);
  }

  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              // Container(
              //     height: 150,
              //     width: screen(context).width,
              //     decoration: BoxDecoration(
              //       color: myColor,
              //       borderRadius:
              //           BorderRadius.vertical(bottom: Radius.circular(45)),
              //     ),
              //     clipBehavior: Clip.hardEdge,
              //     child: CustomPaint(
              //       painter: NestedCirclesPainter(
              //           color: Theme.of(context).cardColor.withOpacity(.1),
              //           posX: 1.3,
              //           posY: .9,
              //           radiusParent: 3,
              //           radiusChild: 6),
              //     )),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Card(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Container(
                              // width: screen(context).width / 2,

                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon:
                                      Icon(UniconsLine.search, size: 20),
                                  contentPadding: EdgeInsets.all(15),
                                  hintText: "Tìm kiếm...",
                                  suffixIcon: MyButton(
                                    width: 40,
                                    icon: Icon(
                                      Icons.history,
                                      color: myColor,
                                    ),
                                    color: Colors.transparent,
                                    boxShadows: [],
                                    onPressed: () {
                                      setState(() {
                                        _searchController.text = "";
                                        loadData();
                                      });
                                    },
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _displayListHistory = _listHistory
                                        .where((item) =>
                                            formatString(item.chandoan)
                                                .contains(
                                                    formatString(value)) ||
                                            formatString(item.loaikcb).contains(
                                                formatString(value)) ||
                                            formatString(item.sohoso).contains(
                                                formatString(value)) ||
                                            formatString(
                                                    item.ngaykham.toString())
                                                .contains(
                                                    formatString(value)) ||
                                            formatString(formatDate(
                                                    item.ngayvaovien))
                                                .contains(formatString(value)))
                                        .toList();

                                    getDSNgay(_displayListHistory);
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: MyButton(
                            onPressed: () {
                              selectRangDate();
                            },
                            label:
                                "${formatDate(ngayBatDau)} - ${formatDate(ngayKetThuc)}",
                            color: Theme.of(context).cardColor,
                            textColor: myColor,
                            width: 200,
                            radius: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: loading
                ? Loading()
                : _displayListHistory.length == 0
                    ? EmptyList()
                    : ListView(
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          for (var nam in _lstNam)
                            Column(
                              children: [
                                DividerTitle(
                                  title:
                                      'Năm $nam (${_yearItemCount[nam] ?? 0})',
                                  dividerColor: myColor,
                                  thickness: 3,
                                  color: myColor,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 4),
                                ),
                                for (var thang in _lstThang)
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      children: [
                                        DividerTitle(
                                          title:
                                              'Tháng ${thang.toString().padLeft(2, '0')}',
                                          dividerColor:
                                              Colors.grey.withOpacity(.4),
                                          thickness: 1,
                                          color: myColor.withOpacity(0.7),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                color:
                                                    Colors.grey.withOpacity(.6),
                                              ),
                                            ),
                                          ),
                                          child: Wrap(
                                            children: [
                                              for (var lsk
                                                  in _displayListHistory)
                                                if (ssNgay(
                                                    lsk.ngaykham, thang, nam))
                                                  Row(
                                                    children: [
                                                      HistoryTime(lsk.ngaykham),
                                                      Expanded(
                                                          child:
                                                              viewHistory(lsk)),
                                                    ],
                                                  ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }

  Widget HistoryTime(DateTime time) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: myColor.withOpacity(.1),
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Text(
            "${DateFormat("hh:mm").format(time)}",
            style: TextStyle(color: myColor, fontWeight: FontWeight.bold),
          ),
          Text(
            "Ngày ${DateFormat("dd").format(time)}",
            style: TextStyle(
                color: myColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget viewHistory(LichSuKhamData data) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      // width: isSmallScreen(context)
      //     ? screen(context).width
      //     : screen(context).width / 2 - 4,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        child: OpenContainer(
          closedColor: Theme.of(context).cardColor,
          closedShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          closedElevation: 0,
          openElevation: 0,
          openBuilder: (context, action) => HistoryDetail_screen(
              idkh: widget.idkh, mahs: data.mahs, ngaykham: data.ngaykham),
          closedBuilder: (context, action) => InkWell(
            onTap: action,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          color: myColor.withOpacity(.1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "Số hồ sơ: ${data.sohoso}",
                                          style: TextStyle(
                                            color: myColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Chẩn đoán: ${checkString(data.chandoan)}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Khám ${toLoaiKham(checkString(data.loaikcb))}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: myColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
