import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/service/provider/class.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:app/src/controllers/MarkDoctor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BacSiBottomSheet extends StatefulWidget {
  BacSiBottomSheet({
    super.key,
    required this.items,
    required this.selectedBacSi,
    required this.loaikham,
  });
  final List<BacSi> items;
  final String selectedBacSi;
  final String loaikham;
  @override
  State<BacSiBottomSheet> createState() => _KhoaBottomSheetState();
}

class _KhoaBottomSheetState extends State<BacSiBottomSheet> {
  @override
  void initState() {
    super.initState();
    _listBacSi = widget.items;
    setState(() {});
  }

  List<BacSi> _listBacSi = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,

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
                hintText: "Tìm kiếm bác sĩ, phòng...",
              ),
              onChanged: (value) {
                setState(() {
                  _listBacSi = widget.items
                      .where((item) =>
                          formatString(item.maBacSi)
                              .contains(formatString(value)) ||
                          formatString(item.tenBacSi)
                              .contains(formatString(value)) ||
                          formatString(item.phong.tenPhong)
                              .contains(formatString(value)))
                      .toList();
                });
              },
            ),
          ),
        ),
        SizedBox(height: 15),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Wrap(
                // alignment: WrapAlignment.center,
                children: _listBacSi
                    .map((e) => DoctorItem(
                          bacsi: e,
                          index: widget.items.indexOf(e),
                          isSelected: widget.selectedBacSi != "" &&
                              widget.selectedBacSi == e.maBacSi,
                          loaikham: widget.loaikham,
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DoctorItem extends StatefulWidget {
  final BacSi bacsi;
  final int index;
  final bool isSelected;
  final String loaikham;
  DoctorItem({
    super.key,
    required this.bacsi,
    required this.index,
    required this.isSelected,
    required this.loaikham,
  });

  @override
  State<DoctorItem> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorItem> {
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
  String checkConvertDouble(dynamic value) {
    return value != null ? value.toString() : '0';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).canvasColor,
      margin: EdgeInsets.all(7),
      elevation: 20,
      child: InkWell(
        onTap: widget.index == -1
            ? null
            : () {
                Navigator.of(context).pop(widget.index);
              },
        child: Container(
          decoration: widget.isSelected
              ? BoxDecoration(
                  border: Border.all(color: myColor, width: 2),
                  borderRadius: BorderRadius.circular(15))
              : BoxDecoration(),
          width: isSmallScreen(context) ? null : 300,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: widget.index != -1
                          ? Container(
                              height: 45,
                              width: 45,
                              child: Image.asset(
                                  "assets/pictures/3DMaleDoctor.png"),
                            )
                          : null,
                      title: Text(
                        "${checkString(widget.bacsi.tenBacSi)}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: widget.isSelected ? myColor : null,
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
                                "${double.parse(checkConvertDouble(widget.bacsi.danhGia)).toStringAsFixed(1)}",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              RatingBar.builder(
                                initialRating: double.parse(
                                    checkConvertDouble(widget.bacsi.danhGia)),
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
                                onRatingUpdate: (rating) {},
                              ),
                              Text(
                                  '  (${checkConvertDouble(widget.bacsi.luotDanhGia)})')
                            ],
                          ),
                          // Text("${widget.bacsi.chuyenmon.toString().trim()}",
                          //     maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text("${widget.bacsi.phong.tenPhong}",
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await MarkDoctor.markDoctor(widget.bacsi.maBacSi);
                      markedDoctors = await MarkDoctor.getMarkDoctors();
                      setState(() {
                        markedDoctors;
                      });
                    },
                    child: Icon(
                        markedDoctors.contains(widget.bacsi.maBacSi)
                            ? CupertinoIcons.bookmark_fill
                            : CupertinoIcons.bookmark,
                        color: myColor,
                        size: 20),
                  ),
                ],
              ),
              widget.loaikham == "BHYT" || widget.loaikham == "KSK"
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Đơn giá: ',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${convertIntThousand(widget.bacsi.dongia)} đ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
