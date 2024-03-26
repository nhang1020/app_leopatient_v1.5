import 'package:app/src/controllers/serviceController/DichVuKhamController.dart';
import 'package:app/src/models/serviceModel/DichVuKham.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/service/provider/serviceProvider.dart';
import 'package:app/src/views/screens/service/widgets/regisedDialog.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:app/src/views/widgets/loadingPage.dart';
import 'package:app/src/views/widgets/pushPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypeDialog extends StatefulWidget {
  const TypeDialog({super.key});

  @override
  State<TypeDialog> createState() => _TypeDialogState();
}

class _TypeDialogState extends State<TypeDialog> {
  List<DichVuKhamData> _listLoaiDichVu = [];
  DichVuKhamData _dichVu = DichVuKhamData(
      loaikham: "",
      tenloai: "",
      thoigian: 0,
      ngaybd: DateTime.now(),
      ngaykt: DateTime.now());
  bool loading = false;
  @override
  void initState() {
    super.initState();
    getLoaiDichVu();
  }

  DichVuKhamController _dichVuKhamController = DichVuKhamController();

  Future<void> getLoaiDichVu() async {
    loading = true;
    try {
      _listLoaiDichVu = await _dichVuKhamController.getLoaiDichVuKham("");

      // _listLoaiDichVu.sort((a, b) {
      //   Map<String, int> order = {
      //     "THUPHI": 0,
      //     "BHYT": 1,
      //     "DICHVU": 2,
      //     "KSK": 3
      //   };
      //   return order[a.loaikham]! - order[b.loaikham]!;
      // });
      setState(() {
        _dichVu = _listLoaiDichVu[0];
      });
    } catch (e) {
      print(e);
    } finally {
      loading = false;
    }
  }

  List<ExpansionTileController> _listController =
      List.generate(3, (index) => ExpansionTileController());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            constraints: BoxConstraints(maxWidth: 400),
            child: Stack(
              children: [
                Container(
                  height: 177,
                  width: screen(context).width,
                  decoration: BoxDecoration(
                    color: myColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    image: DecorationImage(
                        image: AssetImage("assets/images/service/banner.png"),
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).cardColor.withOpacity(.2),
                            BlendMode.srcATop)),
                  ),
                ),
                Container(
                  height: 170,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(
                          "Đặt lịch khám\ntrực tuyến",
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: screen(context).width,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(top: 150),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                      bottom: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "CHỌN LOẠI KHÁM",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: myColor),
                      ),
                      SizedBox(height: 10),
                      loading
                          ? SizedBox(height: 290, child: Loading())
                          : SizedBox(),
                      for (int index = 0;
                          index < _listLoaiDichVu.length;
                          index++)
                        Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          child: RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            value: _listLoaiDichVu[index],
                            groupValue: _dichVu,
                            title: ExpansionTile(
                              childrenPadding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              tilePadding: EdgeInsets.symmetric(horizontal: 10),
                              backgroundColor: Theme.of(context).canvasColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              initiallyExpanded:
                                  _dichVu == _listLoaiDichVu[index],
                              controller: _listController[index],
                              onExpansionChanged: (value) {
                                if (value) {
                                  setState(() {
                                    _dichVu = _listLoaiDichVu[index];
                                  });
                                  for (int i = 0;
                                      i < _listController.length;
                                      i++) {
                                    if (_listController[index] !=
                                        _listController[i]) {
                                      _listController[i].collapse();
                                    }
                                  }
                                }
                              },
                              title: Text(
                                  "${convertFirstUpper(_listLoaiDichVu[index].loaikham == "KSK" ? "Khám sức khỏe" : _listLoaiDichVu[index].tenloai)}"),
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Thời hạn còn: ",
                                    style: TextStyle(color: Colors.grey),
                                    children: [
                                      TextSpan(
                                          text:
                                              "${getDifferentTime(_listLoaiDichVu[index].ngaykt).inHours} giờ ${getDifferentTime(_listLoaiDichVu[index].ngaykt).inMinutes % 60.abs()} phút\n",
                                          style: TextStyle(
                                            color: myColor,
                                          )),
                                      TextSpan(
                                          text:
                                              "${descriptions[_listLoaiDichVu[index].loaikham]}")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            activeColor: myColor,
                            onChanged: _listLoaiDichVu[index]
                                    .ngaykt
                                    .isAfter(DateTime.now())
                                ? <DichVuKhamData>(value) {
                                    // setState(() {
                                    //   _dichVu = value!;
                                    // });
                                  }
                                : null,
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          actions: [
            MyButton(
              width: 110,
              label: "Tiếp tục",
              subfixIcon:
                  Icon(Icons.forward, color: Theme.of(context).cardColor),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PushPage(
                        page: ChangeNotifierProvider(
                          create: (context) => ServiceProvider(),
                          builder: (context, child) =>
                              RegisterDialog(dichVuKham: _dichVu),
                        ),
                      ),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
