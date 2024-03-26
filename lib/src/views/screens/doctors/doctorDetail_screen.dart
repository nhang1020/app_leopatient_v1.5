import 'package:app/src/controllers/serviceController/DichVuKhamController.dart';
import 'package:app/src/models/BacSi.dart';
import 'package:app/src/models/serviceModel/DichVuKham.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/service/provider/serviceProvider.dart';
import 'package:app/src/views/screens/service/widgets/regisedDialog.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:app/src/views/widgets/circleIner.dart';
import 'package:app/src/views/widgets/pushPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class DoctorDetailScreen extends StatefulWidget {
  DoctorDetailScreen({super.key, required this.bacsi});
  final BacSiData bacsi;
  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  List<DichVuKhamData> _listLoaiDichVu = [];
  DichVuKhamData _dichVu = DichVuKhamData(
      loaikham: "",
      tenloai: "",
      thoigian: 0,
      ngaybd: DateTime.now(),
      ngaykt: DateTime.now());

  @override
  void initState() {
    super.initState();
    getLoaiDichVu();
  }

  DichVuKhamController _dichVuKhamController = DichVuKhamController();

  Future<void> getLoaiDichVu() async {
    try {
      _listLoaiDichVu = await _dichVuKhamController.getLoaiDichVuKham("");

      _listLoaiDichVu.sort((a, b) {
        Map<String, int> order = {"THUPHI": 0, "BHYT": 1, "DICHVU": 2};
        return order[a.loaikham]! - order[b.loaikham]!;
      });
      setState(() {
        _dichVu = _listLoaiDichVu[0];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var bacsi = widget.bacsi;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Header(bacsi),
            DividerTitle(title: "Thông tin chi tiết"),
            Middle(bacsi),
            SizedBox(height: 20),
            Bottom(),
          ],
        ),
      ),
    );
  }

  Widget Header(BacSiData bacsi) {
    return Stack(
      children: [
        Container(
          height: 100,
          margin: EdgeInsets.only(top: 110, right: 35, left: 35),
          decoration: BoxDecoration(
            color: myColor.withOpacity(.3),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          height: 100,
          margin: EdgeInsets.only(top: 120, right: 45, left: 45),
          decoration: BoxDecoration(
            color: myColor.withOpacity(.2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 140,
              width: screen(context).width,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: myColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bacsi.tenbs,
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: screen(context).width / 1.5,
                    child: Text(
                      checkString(bacsi.tenkhoa),
                      style: TextStyle(
                        color: Theme.of(context).cardColor.withOpacity(.6),
                        // fontSize: 17,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "${double.parse(bacsi.danhgia.toString()).toStringAsFixed(1)} ",
                        style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      RatingBar.builder(
                        initialRating:
                            double.parse(widget.bacsi.danhgia.toString()),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemSize: 25,
                        itemBuilder: (context, _) =>
                            Icon(Icons.star, color: Colors.yellow),
                        maxRating: 5,
                        unratedColor: Colors.black12,
                        onRatingUpdate: (rating) {
                          // setState(() {
                          //   bacsi.danhgia = rating;
                          // });
                        },
                      ),
                      Text(
                        " (${bacsi.luotdanhgia})",
                        style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                height: 140,
                width: screen(context).width,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                clipBehavior: Clip.hardEdge,
                child: CustomPaint(
                  painter: NestedCirclesPainter(
                      color: Theme.of(context).cardColor.withOpacity(.1),
                      posX: 1.15,
                      posY: 1.5,
                      radiusParent: 3,
                      radiusChild: 6),
                )),
            Container(
              height: 200,
              // width: 100,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  bacsi.gioitinh != null
                      ? bacsi.gioitinh == 1
                          ? Image.asset("assets/pictures/3Ddoctor.png")
                          : Image.asset("assets/pictures/3DMaleDoctor.png")
                      : Image.asset("assets/pictures/3DMaleDoctor.png"),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 190,
              decoration: BoxDecoration(),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(UniconsLine.phone, color: myColor),
                    color: myColor.withOpacity(.15),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(UniconsLine.comment_alt_dots, color: myColor),
                    color: myColor.withOpacity(.15),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget Middle(BacSiData bacsi) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Wrap(
        children: [
          CardInfo(
            title: "Số điện thoại",
            text: checkString(bacsi.sodienthoai),
            icon: UniconsLine.phone,
            color: Colors.teal.shade700,
          ),
          CardInfo(
            title: "Giới tính",
            text: checkGender(bacsi.gioitinh),
            icon: bacsi.gioitinh != null
                ? bacsi.gioitinh == 0
                    ? UniconsLine.mars
                    : UniconsLine.venus
                : UniconsLine.question,
            color: Colors.deepPurple,
          ),
          CardInfo(
            title: "Email",
            text: checkString(bacsi.email),
            icon: Icons.attach_email_outlined,
            color: Colors.blue.shade700,
          ),
          CardInfo(
            title: "Chuyên ngành",
            text: checkString(bacsi.chuyenmon),
            icon: UniconsLine.graduation_cap,
            color: Colors.lime.shade700,
          ),
          CardInfo(
            title: "Phòng",
            text: checkString(bacsi.tenphong),
            icon: UniconsLine.code_branch,
            color: Colors.pink.shade700,
          ),
        ],
      ),
    );
  }

  Widget Bottom() {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DividerTitle(title: "Đặt lịch khám"),
            for (var item in _listLoaiDichVu)
              RadioListTile(
                value: item,
                groupValue: _dichVu,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${item.tenloai}"),
                    Text(
                      "(${formatDateMonth(item.ngaybd)} - ${formatDateMonth(item.ngaykt)})",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
                activeColor: myColor,
                onChanged: item.ngaykt.isAfter(DateTime.now())
                    ? <DichVuKhamData>(value) {
                        setState(() {
                          _dichVu = value!;
                        });
                      }
                    : null,
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: MyButton(
                width: screen(context).width,
                color: myColor.withOpacity(.1),
                subfixIcon: Icon(UniconsLine.book, color: myColor),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => ServiceProvider(),
                          builder: (context, child) => PushPage(
                            page: RegisterDialog(
                                dichVuKham: _dichVu,
                                maBacSi: widget.bacsi.mabs),
                          ),
                        ),
                      ));
                },
                icon: Text(
                  "Đặt lịch khám",
                  style: TextStyle(
                    color: myColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardInfo extends StatelessWidget {
  const CardInfo({
    super.key,
    required this.title,
    required this.text,
    required this.icon,
    required this.color,
  });

  final String title;
  final String text;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Container(
        width: title == "Giới tính" || title == "Số điện thoại"
            ? screen(context).width / 2 - 16
            : null,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: color.withOpacity(.1),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          title: Text(
            "${title}",
            style: TextStyle(color: color, fontSize: 15),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            "${checkString(text)}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
