import 'package:app/src/controllers/MarkDoctor.dart';
import 'package:app/src/models/BacSi.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/doctors/doctorDetail_screen.dart';
import 'package:app/src/views/screens/home/widgets/notificationCenter.dart';
import 'package:app/src/views/screens/home/widgets/scheduleCalendar.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:app/src/views/widgets/pushPage.dart';
import 'package:app/src/views/widgets/searchTextField.dart';
import 'package:app/src/views/widgets/settingDialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:unicons/unicons.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.listBacSi,
  });
  final List<BacSiData> listBacSi;
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<SearchItem> listSearch = [];
  List<BacSiData> displayBacSi = [];

  void setListSearch() {
    listSearch = widget.listBacSi
        .map((e) => SearchItem(
            e.tenbs,
            e.tenbs.contains('BS') || e.tenbs.contains('BS.')
                ? UniconsLine.stethoscope
                : UniconsLine.user_nurse,
            PushPage(page: DoctorDetailScreen(bacsi: e))))
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setListSearch();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        height: screen(context).height,
        child: SingleChildScrollView(
          child: Column(
            children: Header() +
                [
                  CarouselSlider(
                    items: (displayBacSi.isEmpty
                            ? widget.listBacSi.take(5)
                            : displayBacSi)
                        .map((item) => DoctorCard(bacSi: item))
                        .toList(),
                    options: CarouselOptions(
                      height: 125,
                      // aspectRatio: 16 / 5,
                      viewportFraction: isSmallScreen(context) ? .6 : .4,
                      initialPage: 0,
                      disableCenter: false,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      scrollPhysics: BouncingScrollPhysics(),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  ScheduleCalendar(),
                  SizedBox(
                    height: 100,
                  ),
                ],
          ),
        ),
      ),
    );
  }

  List<Widget> Header() {
    return [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icons/patient_logo.png",
                      width: 20,
                      color: myColor,
                    ),
                    Text(
                      "  Leohis App",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Card(
                    elevation: 10,
                    child: MyButton(
                      height: 40,
                      width: 100,
                      icon: Icon(Icons.history_toggle_off_outlined,
                          color: myColor),
                      color: Theme.of(context).cardColor,
                      label: "${formatTimeOfDay(TimeOfDay.now())}",
                      textColor: Colors.grey,
                    ),
                  ),
                  Card(
                    elevation: 10,
                    child: MyButton(
                      width: 50,
                      height: 40,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => NotifitionDialog(),
                        );
                      },
                      color: Theme.of(context).cardColor,
                      icon: Badge(
                        smallSize: 7,
                        backgroundColor: myColor,
                        child: Icon(Icons.notifications, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Column(
              children: [
                Text("Bác sĩ nổi bật"),
              ],
            )
          ],
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.all(10),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: Card(
      //           elevation: 10,
      //           child: Container(
      //             height: 50,
      //             child: MySearchTextField(
      //               listSearch: listSearch,
      //             ),
      //           ),
      //         ),
      //       ),
      //       SizedBox(width: 10),
      //       MyButton(
      //         width: 50,
      //         boxShadows: [
      //           BoxShadow(
      //             offset: Offset(2, 10),
      //             blurRadius: 15,
      //             color: Colors.black12,
      //           )
      //         ],
      //         icon: Icon(
      //           UniconsLine.sliders_v_alt,
      //           color: Theme.of(context).cardColor,
      //         ),
      //         onPressed: () {
      //           showDialog(
      //             context: context,
      //             builder: (context) => SettingDialog(),
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    ];
  }
}

class DoctorCard extends StatefulWidget {
  const DoctorCard({super.key, required this.bacSi});
  final BacSiData bacSi;

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  @override
  void initState() {
    super.initState();
    loadMarkDoctor();
  }

  loadMarkDoctor() async {
    markedDoctors = await MarkDoctor.getMarkDoctors();
    setState(() {
      markedDoctors;
    });
  }

  List<String> markedDoctors = [];

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // color: myColor,
              child: Image.asset(
                widget.bacSi.gioitinh == 0
                    ? "assets/pictures/3DMaleDoctor.png"
                    : "assets/pictures/3Ddoctor.png",
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.bacSi.tenbs,
                          style: TextStyle(
                              color: myColor, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            Text(
                              "${double.parse(widget.bacSi.danhgia.toString())} ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                            RatingBar.builder(
                              initialRating:
                                  double.parse(widget.bacSi.danhgia.toString()),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              ignoreGestures: true,
                              itemSize: 15,
                              itemBuilder: (context, _) =>
                                  Icon(Icons.star, color: myColor),
                              maxRating: 5,
                              unratedColor: Colors.grey.withOpacity(.5),
                              onRatingUpdate: (rating) {},
                            ),
                            Text(
                              " (${widget.bacSi.luotdanhgia})",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                            width: 150,
                            child: Text(
                              "${widget.bacSi.tenkhoa}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      MyButton(
                        icon: Icon(
                          markedDoctors.contains(widget.bacSi.mabs)
                              ? CupertinoIcons.bookmark_fill
                              : CupertinoIcons.bookmark,
                          size: 20,
                          color: myColor,
                        ),
                        height: 50,
                        width: 150,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(20),
                        ),
                        color: myColor.withOpacity(.1),
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        label: "",
                        textColor: myColor,
                        onPressed: () async {
                          await MarkDoctor.markDoctor(widget.bacSi.mabs);
                          markedDoctors = await MarkDoctor.getMarkDoctors();
                          setState(() {
                            markedDoctors;
                          });
                        },
                      ),
                      MyButton(
                        height: 50,
                        width: 80,

                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(20),
                        ),
                        // color: myColor.withOpacity(.1),
                        label: "Chi tiết",
                        // textColor: myColor,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PushPage(
                                    page: DoctorDetailScreen(
                                        bacsi: widget.bacSi)),
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
