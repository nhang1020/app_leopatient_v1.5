import 'package:app/src/controllers/PhongController.dart';
import 'package:app/src/models/Phong.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/doctors/dortorList_screen.dart';
import 'package:app/src/views/widgets/emptyPage.dart';
import 'package:app/src/views/widgets/loadingPage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoomList_screen extends StatefulWidget {
  String maPhong;
  RoomList_screen({super.key, required this.maPhong});

  @override
  State<RoomList_screen> createState() => _RoomList_screenState();
}

class _RoomList_screenState extends State<RoomList_screen> {
  List<PhongData> _listPhong = [];
  PhongController _PhongController = PhongController();

  bool loading = false;

  loadData() async {
    loading = true;
    try {
      _listPhong = await _PhongController.getPhong(widget.maPhong);

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
            : _listPhong.length == 0
                ? EmptyList()
                : ListView(
                    children: <Widget>[
                      for (int index = 0; index < _listPhong.length; index++)
                        viewPhong(_listPhong[index], index),
                    ],
                  ),
      ),
    );
  }

  int select = -1;
  Widget viewPhong(PhongData data, int index) {
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
                    checkString(data.tenviettat),
                    style: TextStyle(color: myColor, fontSize: 18),
                  ),
                  subtitle: Text(
                    checkString(data.tenphong),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Visibility(
                    visible: select == index ? true : false,
                    child: Container(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text('Xem danh sách bác sĩ'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DoctorList_Screen(
                                          maKhoa: '', maPhong: data.maphong)));
                            },
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
