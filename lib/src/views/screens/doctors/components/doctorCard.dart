import 'package:animations/animations.dart';
import 'package:app/src/controllers/MarkDoctor.dart';
import 'package:app/src/models/BacSi.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/doctors/doctorDetail_screen.dart';
import 'package:app/src/views/widgets/pushPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class DoctorCard extends StatefulWidget {
  BacSiData bacsi;
  DoctorCard({
    super.key,
    required this.bacsi,
  });

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

  convertToDouble(dynamic value) {
    try {
      return double.parse(value.toString());
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(7),
      child: OpenContainer(
        transitionDuration: Duration(milliseconds: 400),
        closedElevation: 0,
        closedColor: Theme.of(context).cardColor,
        openColor: Theme.of(context).cardColor,
        closedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        openBuilder: (context, action) => PushPage(
          page: DoctorDetailScreen(bacsi: widget.bacsi),
          title: "Thông tin Bác sĩ",
        ),
        closedBuilder: (context, action) => Container(
          width: isSmallScreen(context) ? null : 300,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          height: 45,
                          width: 45,
                          child: widget.bacsi.gioitinh == null
                              ? Image.asset(
                                  'assets/pictures/male_user_96px.png',
                                  color: myColor)
                              : widget.bacsi.gioitinh == 1
                                  ? Image.asset("assets/pictures/3Ddoctor.png")
                                  : Image.asset(
                                      "assets/pictures/3DMaleDoctor.png"),
                        ),
                        title: Text(
                          "${checkString(widget.bacsi.tenbs)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${convertToDouble(widget.bacsi.danhgia)}",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                RatingBar.builder(
                                  initialRating:
                                      convertToDouble(widget.bacsi.danhgia) / 1,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  ignoreGestures: true,
                                  itemSize: 15,
                                  itemBuilder: (context, _) =>
                                      Icon(Icons.star, color: Colors.amber),
                                  maxRating: 5,
                                  unratedColor: Colors.grey.withOpacity(.5),
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      widget.bacsi.danhgia = rating;
                                    });
                                  },
                                ),
                                Text('  (${widget.bacsi.luotdanhgia})')
                              ],
                            ),
                            // Text("${widget.bacsi.chuyenmon.toString().trim()}",
                            //     maxLines: 1, overflow: TextOverflow.ellipsis),
                            Text("${widget.bacsi.tenkhoa}",
                                maxLines: 1, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await MarkDoctor.markDoctor(widget.bacsi.mabs);
                      markedDoctors = await MarkDoctor.getMarkDoctors();
                      setState(() {
                        markedDoctors;
                      });
                    },
                    child: Icon(
                        markedDoctors.contains(widget.bacsi.mabs)
                            ? CupertinoIcons.bookmark_fill
                            : CupertinoIcons.bookmark,
                        color: myColor,
                        size: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
