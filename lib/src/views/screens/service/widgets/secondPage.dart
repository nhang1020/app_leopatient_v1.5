import 'package:app/src/models/serviceModel/KhungGioKham.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/service/provider/class.dart';
import 'package:app/src/views/screens/service/provider/serviceProvider.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key, required this.listKhungGioKham});
  final List<KhungGioKhamData> listKhungGioKham;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  LichKham lichKham = newlichKham;
  String _selectedGio = "";

  void getGioKham() {
    var provider = Provider.of<ServiceProvider>(context, listen: false);
    lichKham = provider.lichKham;
    setState(() {
      _selectedGio = provider.lichKham.gioKham!;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    getGioKham();

    return Scaffold(
      body: Column(
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
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    DividerTitle(
                      title: "Sáng",
                      thickness: 1,
                      color: Colors.grey,
                      dividerColor: Colors.grey.withOpacity(.6),
                    ),
                    Wrap(
                      runAlignment: WrapAlignment.spaceBetween,
                      children: [
                        for (var i = 0; i < widget.listKhungGioKham.length; i++)
                          DateTime.parse("2022-01-01 ${widget.listKhungGioKham[i].gio}")
                                      .hour <
                                  12
                              ? Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: MyButton(
                                    enabled: widget.listKhungGioKham[i].dangky,
                                    duration: Duration(milliseconds: 200),
                                    textColor: widget.listKhungGioKham[i].gio ==
                                            _selectedGio
                                        ? null
                                        : myColor,
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    boxShadows:
                                        widget.listKhungGioKham[i].gio ==
                                                _selectedGio
                                            ? [
                                                BoxShadow(
                                                  offset: Offset(0, 20),
                                                  color: Theme.of(context)
                                                          .bannerTheme
                                                          .shadowColor ??
                                                      Colors.black26,
                                                  blurRadius: 20,
                                                )
                                              ]
                                            : [],
                                    color: widget.listKhungGioKham[i].gio ==
                                            _selectedGio
                                        ? null
                                        : myColor.withOpacity(.1),
                                    onPressed: () {
                                      setState(() {
                                        _selectedGio =
                                            widget.listKhungGioKham[i].gio;
                                      });
                                      var provider =
                                          Provider.of<ServiceProvider>(context,
                                              listen: false);
                                      provider.setGioKham(_selectedGio);
                                    },
                                    label: removeSeconds(
                                        widget.listKhungGioKham[i].gio),
                                  ),
                                )
                              : SizedBox()
                      ],
                    ),
                    DividerTitle(
                      title: "Chiều",
                      thickness: 1,
                      color: Colors.grey,
                      dividerColor: Colors.grey.withOpacity(.6),
                    ),
                    Wrap(
                      runAlignment: WrapAlignment.spaceBetween,
                      children: [
                        for (var i = 0; i < widget.listKhungGioKham.length; i++)
                          DateTime.parse("2022-01-01 ${widget.listKhungGioKham[i].gio}")
                                      .hour >
                                  12
                              ? Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: MyButton(
                                    enabled: widget.listKhungGioKham[i].dangky,
                                    duration: Duration(milliseconds: 200),
                                    textColor: widget.listKhungGioKham[i].gio ==
                                            _selectedGio
                                        ? null
                                        : myColor,
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    boxShadows:
                                        widget.listKhungGioKham[i].gio ==
                                                _selectedGio
                                            ? [
                                                BoxShadow(
                                                  offset: Offset(0, 20),
                                                  color: Theme.of(context)
                                                          .bannerTheme
                                                          .shadowColor ??
                                                      Colors.black26,
                                                  blurRadius: 20,
                                                )
                                              ]
                                            : [],
                                    color: widget.listKhungGioKham[i].gio ==
                                            _selectedGio
                                        ? null
                                        : myColor.withOpacity(.1),
                                    onPressed: () {
                                      setState(() {
                                        _selectedGio =
                                            widget.listKhungGioKham[i].gio;
                                      });
                                      var provider =
                                          Provider.of<ServiceProvider>(context,
                                              listen: false);
                                      provider.setGioKham(_selectedGio);
                                    },
                                    label: removeSeconds(
                                        widget.listKhungGioKham[i].gio),
                                  ),
                                )
                              : SizedBox()
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String removeSeconds(String timeString) {
    if (timeString.endsWith(":00")) {
      return timeString.substring(0, timeString.length - 3);
    } else {
      return timeString;
    }
  }
}
