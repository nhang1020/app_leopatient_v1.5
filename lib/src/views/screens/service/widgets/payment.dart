import 'dart:convert';

import 'package:app/src/controllers/UserController.dart';
import 'package:app/src/controllers/serviceController/ThanhToanController.dart';
import 'package:app/src/models/User.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/controllers/notification_manager/notification_helper.dart';
import 'package:app/src/views/screens/service/provider/class.dart';
import 'package:app/src/views/widgets/rootWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:restart_app/restart_app.dart';

class Payment extends StatefulWidget {
  const Payment({super.key, required this.input, required this.lichKham});
  final TTInput input;
  final LichKham lichKham;
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  UserData _userData = initUser;
  UserController _userController = UserController();
  bool loading = false;
  String paymentType = "COD";
  Future getUser() async {
    loading = true;
    _userData = await _userController.getUser();
    try {
      setState(() {
        _userData;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getUser().then((value) => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screen(context).height - 50,
          constraints: BoxConstraints(minHeight: 900),
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Text(
                "Trang thanh toán",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .color!
                        .withOpacity(.6)),
              ),
              SizedBox(height: 100),
              Container(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${convertIntThousand(widget.input.tienthanhtoan)} đ",
                          style: TextStyle(
                            color: myColor,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Tổng số tiền",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    _userData.avatar != '' && _userData.avatar != null
                        ? Container(
                            padding: EdgeInsets.all(3),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              image: DecorationImage(
                                image: MemoryImage(
                                  base64Decode(_userData.avatar
                                      .toString()
                                      .substring(
                                          "data:image/png;base64,".length)),
                                ),
                              ),
                            ),
                          )
                        //assets/pictures/user.png
                        : !loading
                            ? Container(
                                padding: EdgeInsets.all(3),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  // image: DecorationImage(
                                  //     image: AssetImage(
                                  //         'assets/pictures/user96px.png'),

                                  //     fit: BoxFit.cover),
                                ),
                                child: Image.asset(
                                  'assets/pictures/user96px.png',
                                  color: Colors.white,
                                  width: 50,
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 25,
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).cardColor,
                                ),
                              ),
                  ],
                ),
              ),
              // SizedBox(height: 30),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 150,
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: myColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            child: Text(
                              "Phương thức thanh toán",
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                    offset: Offset(4, 6),
                                    color: Colors.black26,
                                    blurRadius: 5,
                                  )
                                ],
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  decoration: paymentType == "COD"
                                      ? BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 20),
                                                blurRadius: 30,
                                                color: Colors.black38),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        )
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        paymentType = "COD";
                                      });
                                    },
                                    minLeadingWidth: 0,
                                    leading: Image.asset(
                                        "assets/icons/customs_50px.png",
                                        color: paymentType == "COD"
                                            ? myColor
                                            : Theme.of(context).cardColor,
                                        width: 30),
                                    title: Text(
                                      "COD",
                                      style: TextStyle(
                                          color: paymentType == "COD"
                                              ? myColor
                                              : Theme.of(context).cardColor),
                                    ),
                                    subtitle: Text(
                                      "Thanh toán trực tiếp",
                                      style: TextStyle(
                                          color: paymentType == "COD"
                                              ? myColor.withOpacity(.7)
                                              : Theme.of(context)
                                                  .cardColor
                                                  .withOpacity(.7)),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  decoration: paymentType != "COD"
                                      ? BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 20),
                                                blurRadius: 30,
                                                color: Colors.black38),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        )
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        paymentType = "ONLINE";
                                      });
                                    },
                                    minLeadingWidth: 0,
                                    leading: Image.asset(
                                      "assets/icons/topup_payment_50px.png",
                                      width: 30,
                                      color: paymentType != "COD"
                                          ? myColor
                                          : Theme.of(context).cardColor,
                                    ),
                                    title: Text(
                                      "Online",
                                      style: TextStyle(
                                          color: paymentType != "COD"
                                              ? myColor
                                              : Theme.of(context).cardColor),
                                    ),
                                    subtitle: Text(
                                      "Thanh toán qua ví điện tử",
                                      style: TextStyle(
                                          color: paymentType != "COD"
                                              ? myColor.withOpacity(.7)
                                              : Theme.of(context)
                                                  .cardColor
                                                  .withOpacity(.7)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            height: 120,
                            width: screen(context).width,
                            decoration: BoxDecoration(
                              color: myColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          Container(
                            height: 140,
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                              "assets/icons/coin.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            height: 120,
                            width: screen(context).width,
                            padding: EdgeInsets.all(15),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Thanh toán\nnhanh chóng với ví điện tử",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).cardColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      color: myColor,
                      margin: EdgeInsets.all(25),
                      elevation: 20,
                      shadowColor: Colors.black,
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          try {
                            ThanhToanController controller =
                                ThanhToanController();
                            TTOutput output =
                                await controller.postXacNhanThanhToan(TTInput(
                                    madangky: widget.input.madangky,
                                    phuongthucThanhtoan: paymentType,
                                    tienthanhtoan: widget.input.tienthanhtoan));

                            if (output.success) {
                              var lichKham = widget.lichKham;
                              await NotificationHelper.simpleNotification(
                                title: "Thông báo",
                                body:
                                    "Chúc mừng bạn đã đăng ký lịch khám thành công",
                                showImage: true,
                              );
                              DateFormat format = DateFormat("HH:mm:ss");
                              DateTime dateTime =
                                  format.parse(lichKham.gioKham!);

                              TimeOfDay timeOfDay = TimeOfDay(
                                  hour: dateTime.hour, minute: dateTime.minute);
                              var thoiGian = DateTime(
                                lichKham.ngayDangKy.year,
                                lichKham.ngayDangKy.month,
                                lichKham.ngayDangKy.day,
                                timeOfDay.hour,
                                timeOfDay.minute,
                              );
                              // Thông báo trước 1 ngày

                              if (thoiGian.difference(DateTime.now()).inDays >=
                                      1 &&
                                  thoiGian.isAfter(DateTime.now())) {
                                await NotificationHelper.scheduleNotification(
                                  id: convertDateTimeToInt(
                                      thoiGian.subtract(Duration(days: 1))),
                                  date: thoiGian.subtract(Duration(days: 1)),
                                  title: "Lịch khám bệnh",
                                  body:
                                      "Ngày mai bạn có một lịch khám bệnh với ${lichKham.bacSi.tenBacSi} vào lúc ${formatTimeOfDay(timeOfDay)}",
                                );
                              }
                              //Thông báo trước 3 giờ
                              await NotificationHelper.scheduleNotification(
                                id: convertDateTimeToInt(
                                    thoiGian.subtract(Duration(hours: 3))),
                                date: thoiGian.subtract(Duration(hours: 3)),
                                title: "Lịch khám bệnh",
                                body:
                                    "Hôm nay bạn có một lịch khám bệnh với ${lichKham.bacSi.tenBacSi} vào lúc ${formatTimeOfDay(timeOfDay)}, vui lòng đến sớm 30 phút.",
                              );
                              //Thông báo trước 1 giờ
                              await NotificationHelper.scheduleNotification(
                                id: convertDateTimeToInt(
                                    thoiGian.subtract(Duration(hours: 1))),
                                date: thoiGian.subtract(Duration(hours: 1)),
                                title: "Lịch khám bệnh",
                                body:
                                    "1 giờ sau, bạn có một lịch khám bệnh với ${lichKham.bacSi.tenBacSi} vào lúc ${formatTimeOfDay(timeOfDay)}, vui lòng đến sớm 30 phút.",
                              );

                              // try {
                              //   Restart.restartApp();
                              // } catch (e) {
                              //   print(e);
                              // }
                            } else {
                              print(output.message);
                            }
                          } catch (e) {
                            print(e);
                          } finally {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RootWidget()));
                          }
                        },
                        child: Container(
                          width: 200,
                          alignment: Alignment.center,
                          height: 70,
                          child: Text(
                            "Thanh toán",
                            style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
