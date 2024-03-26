import 'package:app/src/controllers/KhoaController.dart';
import 'package:app/src/controllers/LichSuKhamController.dart';
import 'package:app/src/controllers/PhongController.dart';
import 'package:app/src/models/BacSi.dart';
import 'package:app/src/models/Khoa.dart';
import 'package:app/src/models/LichSuKham.dart';
import 'package:app/src/models/Phong.dart';
import 'package:app/src/utils/theme.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/explore/widgets/menuItem.dart';
import 'package:app/src/views/explore/widgets/searchBar.dart';
import 'package:app/src/views/explore/widgets/video.dart';
import 'package:app/src/views/screens/departmentList_screen.dart';
import 'package:app/src/views/screens/doctors/doctorDetail_screen.dart';
import 'package:app/src/views/screens/doctors/dortorList_screen.dart';
import 'package:app/src/views/screens/history/history_screen.dart';
import 'package:app/src/views/screens/roomList_screen.dart';
import 'package:app/src/views/widgets/pushPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key, required this.idkh, required this.listBacSi});
  final int idkh;
  final List<BacSiData> listBacSi;
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<KhoaData> _listKhoa = [];
  List<PhongData> _listPhong = [];
  List<LichSuKhamData> _listLichSuKham = [];
  Map<String, List<SearchItem>> _items = {
    "Bác sĩ": [],
    "Khoa": [],
    "Phòng": [],
  };
  Future<void> getLichSu() async {
    LichSuKhamController _lichSuKhamController = LichSuKhamController();
    _listLichSuKham = await _lichSuKhamController.getLichSuKham("426875");
    setState(() {});
  }

  Future<void> getKhoa() async {
    KhoaController _khoaController = KhoaController();
    _listKhoa = await _khoaController.getKhoa("");
    setState(() {
      for (var item in _listKhoa) {
        _items["Khoa"]?.add(
          SearchItem(
            item.tenkhoa,
            UniconsLine.building,
            DepartmentList_Screen(maKhoa: item.makhoa),
          ),
        );
      }
    });
  }

  Future<void> getPhong() async {
    PhongController _phongController = PhongController();
    _listPhong = await _phongController.getPhong("");
    setState(() {
      for (var item in _listPhong) {
        _items["Phòng"]?.add(
          SearchItem(
            item.tenphong,
            UniconsLine.bed,
            RoomList_screen(maPhong: item.maphong),
          ),
        );
      }
    });
  }

  Future<void> setSearchItems() async {
    for (var item in widget.listBacSi) {
      _items["Bác sĩ"]?.add(
        SearchItem(
          item.tenbs,
          UniconsLine.stethoscope_alt,
          DoctorDetailScreen(bacsi: item),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getKhoa();
    getLichSu();
    getPhong();
    setSearchItems();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    bool isDarkMode = provider.isDarkMode || provider.isSysDark;
    return SingleChildScrollView(
      child: Container(
        height: screen(context).height,
        child: ListView(
          children: [
            Container(
              // height: 150,
              // decoration: BoxDecoration(
              //   color: myColor,
              //   image: DecorationImage(
              //     image: AssetImage("assets/images/service/bannerService.png"),
              //     fit: BoxFit.cover,
              //   ),
              //   borderRadius: BorderRadius.circular(15),
              // ),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Card(
                    elevation: 20,
                    // margin: EdgeInsets.zero,
                    // shadowColor: Colors.black,
                    child: MySearchBar(listSearch: _items),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Wrap(
                children: [
                  MenuItem(
                    title: "BÁC SĨ",
                    color: Color(0xfffa7781),
                    urlIcon: isDarkMode
                        ? "assets/icons/stethoscope_dark.png"
                        : "assets/icons/stethoscope_light.png",
                    position: 0,
                    length: widget.listBacSi.length,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PushPage(
                              page: DoctorList_Screen(
                            maKhoa: "",
                            maPhong: "",
                            tieuDe: "",
                          )),
                        )),
                  ),
                  MenuItem(
                    title: "LỊCH SỬ KHÁM",
                    color: Color.fromARGB(255, 129, 100, 235),
                    urlIcon: isDarkMode
                        ? "assets/icons/history_dark.png"
                        : "assets/icons/history_light.png",
                    position: 3,
                    length: _listLichSuKham.length,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PushPage(
                              title: "Lịch sử khám bệnh",
                              page: HistoryMedical_Screen(
                                idkh: widget.idkh,
                                listLichSuKham: _listLichSuKham,
                              )),
                        )),
                  ),
                  MenuItem(
                    title: "PHÒNG",
                    color: Color.fromARGB(255, 98, 106, 255),
                    urlIcon: isDarkMode
                        ? "assets/icons/room_dark.png"
                        : "assets/icons/room_light.png",
                    position: 2,
                    length: _listPhong.length,
                  ),
                  MenuItem(
                    title: "KHOA",
                    color: Colors.teal,
                    urlIcon: isDarkMode
                        ? "assets/icons/department_dark.png"
                        : "assets/icons/department_light.png",
                    position: 1,
                    length: _listKhoa.length,
                  ),
                ],
              ),
            ),
            // VideoPLay(),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
