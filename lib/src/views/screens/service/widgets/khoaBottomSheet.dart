import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/service/provider/class.dart';

import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class KhoaBottomSheet extends StatefulWidget {
  KhoaBottomSheet({
    super.key,
    required this.items,
    required this.selectedKhoa,
  });
  final List<Khoa> items;
  final String selectedKhoa;
  @override
  State<KhoaBottomSheet> createState() => _KhoaBottomSheetState();
}

class _KhoaBottomSheetState extends State<KhoaBottomSheet> {
  @override
  void initState() {
    super.initState();
    _listKhoa = widget.items;
    setState(() {});
  }

  List<Khoa> _listKhoa = [];
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
                hintText: "Tìm kiếm khoa...",
              ),
              onChanged: (value) {
                setState(() {
                  _listKhoa = widget.items
                      .where((item) =>
                          formatString(item.maKhoa)
                              .contains(formatString(value)) ||
                          formatString(item.tenKhoa)
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
                children: _listKhoa
                    .map(
                      (e) => Card(
                        color: widget.selectedKhoa == e.maKhoa &&
                                widget.selectedKhoa != ""
                            ? myColor
                            : null,
                        elevation: widget.selectedKhoa == e.maKhoa &&
                                widget.selectedKhoa != ""
                            ? 30
                            : null,
                        shadowColor: widget.selectedKhoa == e.maKhoa &&
                                widget.selectedKhoa != ""
                            ? Colors.black87
                            : null,
                        margin: EdgeInsets.all(5),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop(widget.items.indexOf(e));
                          },
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              e.tenKhoa,
                              style: TextStyle(
                                  color: widget.selectedKhoa == e.maKhoa &&
                                          widget.selectedKhoa != ""
                                      ? Theme.of(context).cardColor
                                      : null),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
