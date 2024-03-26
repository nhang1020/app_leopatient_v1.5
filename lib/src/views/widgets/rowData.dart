import 'package:flutter/material.dart';

Widget RowData(String left, double sizeLeft, String right, double sizeRight) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Container(
      child: Row(children: [
        Text(
          left,
          style: TextStyle(
            fontSize: sizeLeft,
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              right,
              style: TextStyle(
                fontSize: sizeRight,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ]),
    ),
  );
}

Widget RowData2(
  String left,
  double sizeLeft,
  String right,
  double sizeRight,
) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Container(
      child: Row(children: [
        Text(
          left,
          style: TextStyle(
            fontSize: sizeLeft,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              right,
              style: TextStyle(
                fontSize: sizeRight,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ]),
    ),
  );
}

// ignore: must_be_immutable
class LineData extends StatelessWidget {
  LineData(
      {super.key,
      required this.left,
      required this.right,
      this.sizeLeft,
      this.sizeRight,
      this.maxLines,
      this.textAlign,
      this.minWidth});
  String left;
  double? sizeLeft;
  String right;
  double? sizeRight;
  int? maxLines;
  TextAlign? textAlign;
  double? minWidth;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            alignment: Alignment.topLeft,
            constraints: BoxConstraints(minWidth: minWidth ?? 100),
            child: Text(
              left,
              style: TextStyle(
                fontSize: sizeLeft,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                right,
                style: TextStyle(
                  fontSize: sizeRight,
                  color: left.contains('Thành tiền')
                      ? Colors.greenAccent.shade700
                      : null,
                  fontWeight: left.contains('Thành tiền')
                      ? FontWeight.bold
                      : FontWeight.w400,
                ),
                textAlign: textAlign != null ? textAlign : TextAlign.right,
                maxLines: maxLines == null ? 100 : maxLines,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
