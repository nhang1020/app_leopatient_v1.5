import 'package:app/src/controllers/BacSiController.dart';
import 'package:app/src/controllers/KhoaController.dart';
import 'package:app/src/controllers/MarkDoctor.dart';
import 'package:app/src/models/BacSi.dart';
import 'package:app/src/models/Khoa.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/doctors/components/doctorCard.dart';
import 'package:app/src/views/widgets/dropDown.dart';
import 'package:app/src/views/widgets/loadingCard.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import '../../widgets/emptyPage.dart';

// ignore: must_be_immutable
class DoctorList_Screen extends StatefulWidget {
  String maKhoa;
  String maPhong;
  final String? tieuDe;
  DoctorList_Screen(
      {super.key, required this.maKhoa, required this.maPhong, this.tieuDe});

  @override
  State<DoctorList_Screen> createState() => _DoctorList_ScreenState();
}

class _DoctorList_ScreenState extends State<DoctorList_Screen> {
  List<BacSiData> _lstBacSi = [];
  List<BacSiData> _displayLstBacSi = [];
  BacSiController _bacSiController = BacSiController();
  KhoaController _khoaController = KhoaController();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = _listKhoa
        .map((khoa) => DropdownMenuItem(
            child: Container(
                child: Text(khoa.tenkhoa,
                    overflow: TextOverflow.ellipsis, maxLines: 1)),
            value: khoa.makhoa))
        .toList();

    return [DropdownMenuItem(child: Text("Tất cả"), value: '')] + menuItems;
  }

  bool loading = false;
  List<KhoaData> _listKhoa = [];
  List<String> _listIdBacSi = [];
  void getListIdBacSi() async {
    _listIdBacSi = await MarkDoctor.getMarkDoctors();
    setState(() {
      _listIdBacSi;
    });
  }

  loadData() async {
    loading = true;
    try {
      _lstBacSi =
          await _bacSiController.getBacSi(widget.maPhong, widget.maKhoa);

      setState(() {
        _lstBacSi;
        _displayLstBacSi = _lstBacSi;
      });
    } catch (e) {
    } finally {
      loading = false;
    }
  }

  loadKhoa() async {
    try {
      _listKhoa = await _khoaController.getKhoa(widget.maKhoa);

      setState(() {});
    } catch (e) {}
  }

  @override
  void initState() {
    loadData();
    loadKhoa();
    getListIdBacSi();
    super.initState();
  }

  String _selectedKhoa = '';
  bool isMarked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screen(context).height,
        child: Column(
          children: [
            Container(
              height: 240,
              padding: EdgeInsets.all(10),
              width: screen(context).width,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
                // color: Colors.white,
                // boxShadow: [boxShadows[0]],
              ),
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      // width: 300,
                      height: 45,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10),

                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(UniconsLine.search, size: 20),
                          hintText: "Tìm kiếm bác sĩ...",
                        ),
                        onChanged: (value) {
                          if (_selectedKhoa != '') {
                            setState(() {
                              _selectedKhoa = '';
                            });
                          }
                          if (_selectedStar != -1) {
                            setState(() {
                              _selectedStar = -1;
                            });
                          }

                          setState(() {
                            _displayLstBacSi = _lstBacSi
                                .where((item) =>
                                    formatString(item.tenbs)
                                        .contains(formatString(value)) ||
                                    formatString(item.tenkhoa)
                                        .contains(formatString(value)) ||
                                    formatString(item.tenphong)
                                        .contains(formatString(value)))
                                .toList();
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.all(5),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        CardStar(-1),
                        CardStar(0),
                        CardStar(4),
                        CardStar(3),
                        CardStar(2),
                        CardStar(1),
                      ],
                    ),
                  )),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          width: 300,
                          padding: EdgeInsets.only(left: 10),
                          child: MyDropdown(
                            items: dropdownItems,
                            value: _selectedKhoa,
                            onChanged: (value) {
                              setState(() {
                                isMarked = false;
                                _selectedKhoa = value!;
                                _selectedStar = -1;
                                _displayLstBacSi = _lstBacSi
                                    .where((element) => element.makhoa == value)
                                    .toList();
                                if (value == '') {
                                  _displayLstBacSi = _lstBacSi;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: CheckboxListTile(
                          checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          activeColor: myColor,
                          title: Text(
                            "Đã lưu",
                            textAlign: TextAlign.right,
                          ),
                          value: isMarked,
                          onChanged: (value) async {
                            _listIdBacSi = await MarkDoctor.getMarkDoctors();
                            setState(() {
                              _listIdBacSi;
                              isMarked = value!;
                              if (isMarked) {
                                _displayLstBacSi = _lstBacSi
                                    .where((element) =>
                                        _listIdBacSi.contains(element.mabs))
                                    .toList();
                              } else {
                                _displayLstBacSi = _lstBacSi;
                              }
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: loading
                  ? Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Wrap(
                        children: List.generate(10, (index) => LoadingCard()),
                      ),
                    )
                  : _displayLstBacSi.length == 0
                      ? EmptyList()
                      : Scrollbar(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(14),
                            physics: BouncingScrollPhysics(),
                            child: Wrap(
                              children: <Widget>[
                                for (int index = 0;
                                    index < _displayLstBacSi.length;
                                    index++)
                                  DoctorCard(bacsi: _displayLstBacSi[index]),
                              ],
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  setList(double countStar) async {
    _selectedStar = countStar;

    // if (countStar != -1) {
    //   _selectedKhoa != ''
    //       ? _displayLstBacSi = _lstBacSi
    //           .where((element) =>
    //               element.makhoa == _selectedKhoa &&
    //               (_selectedStar == 0
    //                   ? (element.danhgia == _selectedStar)
    //                   : (element.danhgia > _selectedStar &&
    //                       element.danhgia <= _selectedStar + 1)))
    //           .toList()
    //       : _displayLstBacSi = _lstBacSi
    //           .where((element) => (_selectedStar == 0 && element.danhgia != null
    //               ? (element.danhgia == _selectedStar)
    //               : (element.danhgia > _selectedStar &&
    //                   element.danhgia <= _selectedStar + 1)))
    //           .toList();
    //   count = _displayLstBacSi.length;
    // } else {
    //   _selectedKhoa != ''
    //       ? _displayLstBacSi = _lstBacSi
    //           .where((element) => element.makhoa == _selectedKhoa)
    //           .toList()
    //       : _displayLstBacSi = _lstBacSi;
    // }
  }

  double _selectedStar = -1;
  int count = 0;
  bool load = false;
  Widget CardStar(double countStar) {
    return InkWell(
      onTap: () {
        setList(countStar).then((value) => load = false);
        setState(() {});
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Container(
          // width: 110,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _selectedStar == countStar ? myColor : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    countStar >= 0
                        ? countStar == 0
                            ? "Chưa đánh giá"
                            : "${countStar.toStringAsFixed(0)} ~ ${(countStar + 1).toStringAsFixed(0)}"
                        : "Tất cả",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _selectedStar == countStar ? Colors.white : null,
                    ),
                  ),
                  countStar >= 0
                      ? countStar != 0
                          ? Icon(
                              Icons.star,
                              color: Colors.amberAccent,
                            )
                          : SizedBox(height: 25)
                      : SizedBox(),
                ],
              ),
              countStar >= 0
                  ? (_selectedStar == countStar
                      ? Text(
                          "Số lượng (${count})",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: _selectedStar == countStar
                                  ? Colors.white
                                  : null),
                        )
                      : SizedBox())
                  : Icon(Icons.list, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
