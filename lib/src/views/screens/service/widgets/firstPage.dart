import 'package:app/src/models/serviceModel/LichDichVuKham.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/service/provider/class.dart';
import 'package:app/src/views/screens/service/provider/serviceProvider.dart';
import 'package:app/src/views/screens/service/widgets/bacSiBottomSheet.dart';
import 'package:app/src/views/screens/service/widgets/emptyWidget.dart';
import 'package:app/src/views/screens/service/widgets/khoaBottomSheet.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class FirstPage extends StatefulWidget {
  const FirstPage(
      {super.key,
      required this.listLichDichVuKham,
      required this.loaiKham,
      this.maBacSi});
  final List<LichDichVuKhamData> listLichDichVuKham;
  final LoaiKham loaiKham;
  final String? maBacSi;
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  //
  int _index = 0;
  List<IconData> _iconDatas = [
    Icons.calendar_month,
    Icons.business,
    UniconsLine.stethoscope,
  ];
  List<DateTime?> _listDateTime = [];
  List<Khoa> _listKhoa = [];
  List<BacSi> _listBacSi = [];

  DateTime? _selectedDate = DateTime(0);
  Khoa _selectedKhoa = Khoa(maKhoa: "", tenKhoa: "");
  BacSi _selectedBacSi =
      BacSi(maBacSi: "", tenBacSi: "", phong: Phong(maPhong: "", tenPhong: ""));
  void setListDateTime() {
    setState(() {
      _listDateTime =
          widget.listLichDichVuKham.map((e) => e.ngaykham).toSet().toList();

      widget.listLichDichVuKham.map((e) => print(e.toJson()));
    });
  }

  @override
  void initState() {
    super.initState();
    setListDateTime();
    if (widget.maBacSi != null) {
      widget.listLichDichVuKham
          .where((element) => element.mabs == widget.maBacSi)
          .toList()
          .map((e) {
        _selectedBacSi = BacSi(
            dongia: e.dongiaBv,
            maBacSi: e.mabs,
            tenBacSi: e.tenbs,
            phong: Phong(maPhong: e.maphong, tenPhong: e.tenphong));

        _selectedKhoa = Khoa(maKhoa: e.makhoa, tenKhoa: e.tenkhoa);
      }).toList();
    }
  }

  nextStep() {
    if (_index < 2) {
      setState(() {
        _index += 1;
      });
    }
  }

  changeProvider() {
    var provider = Provider.of<ServiceProvider>(context, listen: false);
    provider.updateLicKham(LichKham(
        loaiKham: widget.loaiKham,
        ngayDangKy: _selectedDate!,
        khoa: _selectedKhoa,
        bacSi: _selectedBacSi,
        gioKham: ""));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stepper(
      // margin: EdgeInsets.only(left: 40),
      physics: BouncingScrollPhysics(),
      currentStep: _index,
      stepIconBuilder: (stepIndex, stepState) {
        return Icon(_iconDatas[stepIndex],
            size: 18, color: _index == stepIndex ? myColor : Colors.grey);
      },
      connectorColor: MaterialStatePropertyAll(myColor.withOpacity(.1)),
      connectorThickness: 3,
      controlsBuilder: (context, details) {
        return _index == 0
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MyButton(
                      icon: Icon(Icons.keyboard_backspace_outlined,
                          size: 20, color: myColor),
                      width: 110,
                      height: 40,
                      onPressed: () {
                        if (_index > 0) {
                          setState(() {
                            _index -= 1;
                          });
                        }
                      },
                      label: 'Trở lại',
                      textColor: myColor,
                      color: myColor.withOpacity(0),
                    ),
                  ],
                ),
              );
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          subtitle: Text(
              "${_selectedDate != DateTime(0) ? 'Ngày đã chọn: (${formatDateVi(_selectedDate)})' : ''}"),
          title: Text(
            '1. Chọn ngày khám',
            style: TextStyle(color: _index == 0 ? myColor : Colors.grey),
          ),
          content: SizedBox(
            width: screen(context).width,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    _listDateTime.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/icons/empty.png",
                                  width: 200,
                                  color: Colors.grey.withOpacity(.8),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Lịch trống  ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                    for (int index = 0; index < _listDateTime.length; index++)
                      Container(
                        margin: EdgeInsets.only(right: 10, bottom: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selectedDate == _listDateTime[index]
                              ? myColor
                              : myColor.withOpacity(.1),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: !(_selectedDate == _listDateTime[index])
                              ? []
                              : [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 15,
                                      offset: Offset(-7, 10))
                                ],
                        ),
                        child: Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          color: Colors.transparent,
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap: () {
                              if (_selectedDate != _listDateTime[index]) {
                                setState(() {
                                  _selectedDate = _listDateTime[index];
                                });
                                if (widget.maBacSi == null) {
                                  nextStep();
                                  _selectedKhoa = Khoa(maKhoa: "", tenKhoa: "");
                                  _selectedBacSi = BacSi(
                                      maBacSi: "",
                                      tenBacSi: "",
                                      phong: Phong(maPhong: "", tenPhong: ""));
                                  _listBacSi = [];
                                  setState(() {
                                    _listKhoa = widget.listLichDichVuKham
                                        .where((element) =>
                                            element.ngaykham == _selectedDate)
                                        .toList()
                                        .map((e) => Khoa(
                                            maKhoa: e.makhoa,
                                            tenKhoa: e.tenkhoa))
                                        .toSet()
                                        .toList();
                                  });
                                }

                                changeProvider();
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${_listDateTime[index]?.day}",
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: _selectedDate ==
                                                _listDateTime[index]
                                            ? Theme.of(context).cardColor
                                            : myColor),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Tháng ${_listDateTime[index]?.month}",
                                    style: TextStyle(
                                        color: _selectedDate ==
                                                _listDateTime[index]
                                            ? Theme.of(context).cardColor
                                            : Theme.of(context)
                                                .textTheme
                                                .displayLarge!
                                                .color),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),

          // Container(
          //   margin: EdgeInsets.all(10),
          //   alignment: Alignment.center,
          //   child: MyButton(
          //     width: 160,
          //     height: 40,
          //     label: "Chọn ngày đăng ký",
          //     onPressed: () {
          //       var ngay = _showModalBottomSheet(
          //           NgayDangKyBottomSheet(
          //             items: _listDateTime,
          //             selectedNgayDangKy: _selectedDate,
          //           ),
          //           height: screen(context).height / 2);
          //       ngay.then((value) {
          //         if (value != null) {
          //           if (_selectedDate != _listDateTime[value]) {
          //             setState(() {
          //               _selectedDate = _listDateTime[value];
          //             });
          //             if (widget.maBacSi == null) {
          //               nextStep();
          //               _selectedKhoa = Khoa(maKhoa: "", tenKhoa: "");
          //               _selectedBacSi = BacSi(
          //                   maBacSi: "",
          //                   tenBacSi: "",
          //                   phong: Phong(maPhong: "", tenPhong: ""));
          //               _listBacSi = [];
          //               setState(() {
          //                 _listKhoa = widget.listLichDichVuKham
          //                     .where((element) =>
          //                         element.ngaykham == _selectedDate)
          //                     .toList()
          //                     .map((e) =>
          //                         Khoa(maKhoa: e.makhoa, tenKhoa: e.tenkhoa))
          //                     .toSet()
          //                     .toList();
          //               });
          //             }

          //             changeProvider();
          //           }
          //         }
          //       });
          //     },
          //   ),
          // ),
        ),
        Step(
          state:
              widget.maBacSi != null ? StepState.disabled : StepState.indexed,
          title: Text(
            '2. Chọn khoa',
            style: TextStyle(color: _index == 1 ? myColor : Colors.grey),
          ),
          subtitle: Text(
              "${_selectedKhoa.maKhoa != '' ? 'Khoa đã chọn: (${_selectedKhoa.tenKhoa})' : '(Vui lòng chọn khoa)'}"),
          content: Column(
            children: [
              _selectedKhoa.maKhoa != ""
                  ? SizedBox()
                  : EmptyWidget(title: "Chưa chọn bất kỳ khoa nào?"),
              SizedBox(height: 30),
              Container(
                height: 40,
                width: 160,
                child: MyButton(
                  label: "Chọn khoa đăng ký",
                  // textColor: myColor,
                  // color: myColor.withOpacity(.1),
                  enabled: _selectedDate != DateTime(0),
                  onPressed: () {
                    var khoa = _showModalBottomSheet(KhoaBottomSheet(
                        items: _listKhoa, selectedKhoa: _selectedKhoa.maKhoa));
                    khoa.then((value) {
                      if (value != null) {
                        setState(() {
                          Khoa khoa = _listKhoa[value];

                          if (_selectedKhoa != khoa) {
                            _selectedBacSi = BacSi(
                                maBacSi: "",
                                tenBacSi: "",
                                phong: Phong(maPhong: "", tenPhong: ""));
                            changeProvider();
                            _selectedKhoa = khoa;

                            _listBacSi = widget.listLichDichVuKham
                                .where(
                                    (element) => element.makhoa == khoa.maKhoa)
                                .toList()
                                .map((e) => BacSi(
                                    maBacSi: e.mabs,
                                    tenBacSi: e.tenbs,
                                    luotDanhGia: e.luotdanhgia,
                                    danhGia: e.danhgia,
                                    dongia: e.dongiaBv,
                                    phong: Phong(
                                        maPhong: e.maphong,
                                        tenPhong: e.tenphong)))
                                .toSet()
                                .toList();
                            nextStep();
                          }
                        });
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Step(
          state:
              widget.maBacSi != null ? StepState.disabled : StepState.indexed,
          title: Text(
            '3. Chọn bác sĩ',
            style: TextStyle(color: _index == 2 ? myColor : Colors.grey),
          ),
          subtitle: Text(
              "${_selectedBacSi.maBacSi != '' ? 'Bác sĩ đã chọn: (${_selectedBacSi.tenBacSi})' : '(Vui lòng chọn bác sĩ)'}"),
          content: Column(
            children: [
              _selectedBacSi.maBacSi != ""
                  ? DoctorItem(
                      bacsi: _selectedBacSi,
                      index: -1,
                      isSelected: false,
                      loaikham: widget.loaiKham.loaiKham,
                    )
                  : EmptyWidget(
                      title: "Chưa chọn bác sĩ nào",
                    ),
              SizedBox(height: 30),
              Container(
                height: 40,
                child: MyButton(
                  enabled: _selectedKhoa.maKhoa != "",
                  label: _selectedKhoa.maKhoa != ""
                      ? "Chọn bác sĩ"
                      : "Chọn khoa khám trước",
                  onPressed: () {
                    var khoa = _showModalBottomSheet(BacSiBottomSheet(
                      items: _listBacSi,
                      selectedBacSi: _selectedBacSi.maBacSi,
                      loaikham: widget.loaiKham.loaiKham,
                    ));
                    khoa.then((value) {
                      if (value != null) {
                        setState(() {
                          _selectedBacSi = _listBacSi[value];
                        });
                        changeProvider();
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future _showModalBottomSheet(Widget widget, {double? height}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      constraints:
          BoxConstraints(maxHeight: height ?? screen(context).height / 1.2),
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      builder: (BuildContext context) {
        return widget;
      },
    );
  }
}


// Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Scrollbar(
//                     child: SingleChildScrollView(
//                       physics: BouncingScrollPhysics(),
//                       child: Wrap(
//                         children: _listDateTime
//                             .map((e) => Container(
//                                   margin: const EdgeInsets.all(4.0),
//                                   child: MyButton(
//                                     duration: Duration(milliseconds: 200),
//                                     radius: 5,
//                                     width: isSmallScreen(context)
//                                         ? screen(context).width / 4
//                                         : screen(context).width / 6,
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 0, vertical: 20),
//                                     color: _selectedDate == e
//                                         ? null
//                                         : myColor.withOpacity(.1),
//                                     textColor:
//                                         _selectedDate == e ? null : myColor,
//                                     onPressed: () {
//                                       nextStep();
//                                       if (_selectedDate != e) {
//                                         _selectedKhoa =
//                                             Khoa(maKhoa: "", tenKhoa: "");
//                                         _selectedBacSi = BacSi(
//                                             maBacSi: "",
//                                             tenBacSi: "",
//                                             phong: Phong(
//                                                 maPhong: "", tenPhong: ""));
//                                         _listBacSi = [];
//                                       }
//                                       setState(() {
//                                         _selectedDate = e!;
//                                         _listKhoa = widget.listLichDichVuKham
//                                             .where((element) =>
//                                                 element.ngaykham ==
//                                                 _selectedDate)
//                                             .toList()
//                                             .map((e) => Khoa(
//                                                 maKhoa: e.makhoa,
//                                                 tenKhoa: e.tenkhoa))
//                                             .toSet()
//                                             .toList();
//                                       });
//                                       changeProvider();
//                                     },
//                                     label: formatDateVi(e),
//                                   ),
//                                 ))
//                             .toList(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
          