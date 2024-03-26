import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:animations/animations.dart';

import 'package:diacritic/diacritic.dart';

// Color myColor = Color.fromARGB(255, 0, 154, 113);
Color myColor = Color.fromARGB(255, 95, 66, 241);

List<Color> lightThemes = [
  Color(0xff2d70e2),
  Color.fromARGB(255, 201, 163, 113),
  Colors.teal,
  Colors.pink.shade300,
  Color.fromARGB(255, 107, 99, 250),
];
List<Color> darkThemes = [
  Color.fromARGB(255, 113, 175, 255),
  Color.fromARGB(255, 218, 183, 136),
  Colors.tealAccent.shade400,
  Colors.pink.shade200,
  Color.fromARGB(255, 249, 238, 110),
];
Size screen(BuildContext context) {
  return MediaQuery.of(context).size;
}

bool isSmallScreen(BuildContext context) {
  return MediaQuery.of(context).copyWith().size.width < 720;
}

String checkString(String? value) {
  return value == null || value == "" ? "--" : value;
}

formatTime(DateTime time) {
  String formattedTime = DateFormat('hh:mm a').format(time);
  return formattedTime;
}

formatDateVi(DateTime? time) {
  return "${DateFormat('dd').format(time!)} thg ${DateFormat('MM').format(time)} ${time.year}";
}

formatDateVi2(DateTime? time) {
  return "${DateFormat('dd').format(time!)} tháng ${time.month} năm ${time.year}";
}

formatDate(DateTime time) {
  String formatedDate = DateFormat('dd/MM/yyyy').format(time);
  return formatedDate;
}

Duration getDifferentTime(DateTime dateTime) {
  return dateTime.difference(DateTime.now());
}

Map<String, String> descriptions = {
  "THUPHI":
      "Khám chữa bệnh không có thẻ bảo hiểm y tế, chi trả chi phí tương ứng với dịch vụ y tế hóa đơn chăm sóc sức khỏe nhận được.",
  "BHYT":
      "Khám chữa bệnh bằng thẻ bảo hiểm y tế, nhận các dịch vụ hỗ trợ theo chính sách và điều khoản BHYT",
  "DICHVU":
      "Khám chữa bệnh khi đăng ký dịch vụ với Bác sĩ khám, hưởng các quyền lợi riêng của dịch vụ cung cấp.",
  "KSK": "",
};
String convertIntThousand(int number) =>
    NumberFormat.decimalPattern().format(number);
String convertDoubleThousand(double number) =>
    NumberFormat.decimalPattern().format(number);
List<BoxShadow> boxShadows = [
  BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 13,
      color: Color.fromARGB(255, 227, 238, 232)),
  BoxShadow(
      spreadRadius: 3,
      blurRadius: 5,
      color: Color.fromARGB(255, 237, 245, 245)),
];

formatTimeOfDay(TimeOfDay time) {
  return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
}

int convertDateTimeToInt(DateTime dateTime) {
  return int.parse(
      "${dateTime.day}${dateTime.month}${dateTime.hour}${dateTime.minute}");
}

String convertFirstUpper(String string) {
  return "${string.toLowerCase().replaceRange(0, 1, string[0].toUpperCase())}";
}

// ignore: must_be_immutable
class DividerTitle extends StatelessWidget {
  DividerTitle(
      {super.key,
      required this.title,
      this.dividerColor,
      this.color,
      this.padding,
      this.icon,
      this.thickness});
  String title;

  Color? dividerColor;
  Color? color;
  double? thickness;
  EdgeInsets? padding;
  Icon? icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          icon != null
              ? Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: icon,
                )
              : SizedBox(),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 15, color: color),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Divider(
              height: 20,
              thickness: thickness ?? 2,
              color: dividerColor ?? myColor,
            ),
          ),
        ],
      ),
    );
  }
}

String formatString(String text) => removeDiacritics(text).toLowerCase();
String formatDateMonth(DateTime time) {
  return DateFormat('dd/MM').format(time);
}

String checkGender(var gender) {
  if (gender == null) {
    return "Khác";
  }
  return gender == 0 ? "Nam" : "Nữ";
}
