import 'package:app/src/controllers/KhoaController.dart';
import 'package:app/src/models/Khoa.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/doctors/dortorList_screen.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:app/src/views/widgets/emptyPage.dart';
import 'package:app/src/views/widgets/loadingPage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DepartmentList_Screen extends StatefulWidget {
  String maKhoa;
  DepartmentList_Screen({super.key, required this.maKhoa});

  @override
  State<DepartmentList_Screen> createState() => _DepartmentList_ScreenState();
}

class _DepartmentList_ScreenState extends State<DepartmentList_Screen> {
  List<KhoaData> _listKhoa = [];
  KhoaController _khoaController = KhoaController();

  bool loading = false;

  loadData() async {
    loading = true;
    try {
      _listKhoa = await _khoaController.getKhoa(widget.maKhoa);

      setState(() {});
    } catch (e) {
    } finally {
      loading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: loading
            ? Loading()
            : _listKhoa.length == 0
                ? EmptyList()
                : ListView(
                    children: <Widget>[
                      for (int index = 0; index < _listKhoa.length; index++)
                        viewKhoa(_listKhoa[index], index),
                    ],
                  ),
      ),
    );
  }

  int select = -1;
  Widget viewKhoa(KhoaData data, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (select != -1) {
            setState(() {
              select = -1;
            });
          } else {
            setState(() {
              select = index;
            });
          }
        },
        child: Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    data.tenviettat,
                    style: TextStyle(color: myColor, fontSize: 18),
                  ),
                  subtitle: Text(
                    data.tenkhoa,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        label: 'Xem danh sách bác sĩ',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorList_Screen(
                                maKhoa: data.makhoa,
                                maPhong: '',
                                tieuDe: "Bác sĩ ${data.tenkhoa}",
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
