import 'dart:convert';
import 'dart:io';

import 'package:app/src/controllers/UserController.dart';
import 'package:app/src/models/ImageHelper.dart';
import 'package:app/src/models/User.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:app/src/views/widgets/notifications.dart';
import 'package:app/src/views/widgets/settingDialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/variables.dart';
import 'package:unicons/unicons.dart';
import 'package:image_cropper/image_cropper.dart';

// ignore: must_be_immutable
class UserInfo_Screen extends StatefulWidget {
  Function()? loadUserData;
  UserData user;
  UserInfo_Screen({super.key, this.loadUserData, required this.user});

  @override
  State<UserInfo_Screen> createState() => _UserInfo_ScreenState();
}

final imageHelper = ImageHelper();

class _UserInfo_ScreenState extends State<UserInfo_Screen> {
  UserController _userController = UserController();

  bool loading = false;
  Future updateAvatar(final files, String idkh) async {
    if (files.isNotEmpty) {
      final croppedFile = await imageHelper.crop(
          file: files.first, cropStyle: CropStyle.circle);
      if (croppedFile != null) {
        Navigator.pop(context);
        setState(() {
          _image = File(croppedFile.path);
        });

        String img64 = base64Encode(_image!.readAsBytesSync());
        bool response = await _userController.updateAvatar(
            idkh, "data:image/png;base64,${img64}");

        if (response) {
          ScaffoldMessenger.of(context).showSnackBar(MyNotifications()
              .successSnackBar("Cập nhật ảnh đại diện thành công."));
          widget.loadUserData!();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(MyNotifications()
              .errorSnackBar("Cập nhật ảnh đại diện thất bại."));
        }
      }
    }
  }

  File? _image;
  @override
  void initState() {
    super.initState();
    // loadData();
  }

  toBase64String(String text) {
    var lst = text.split('base64,');
    return lst.last;
  }

  String subStringImage(String? image) {
    return "";
  }

  @override
  Widget build(BuildContext context) {
    UserData _userData = widget.user;
    return Scaffold(
      // backgroundColor: Color.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Header(_userData),
              Body(_userData),
              Bottom(_userData),
            ],
          ),
        ),
      ),
    );
  }

  Widget Header(UserData _userData) => Stack(
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(60)),
              gradient: LinearGradient(
                colors: [
                  myColor,
                  myColor,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.bottomCenter,
            child: Image.asset("assets/pictures/White-Wave-PNG-Image.png",
                color: Theme.of(context).canvasColor.withOpacity(.3),
                width: screen(context).width,
                fit: BoxFit.fitWidth),
          ),
          SafeArea(
            child: Container(
              // height: 230,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        child: widget.loadUserData == null
                            ? Card(
                                color: Colors.transparent,
                                elevation: 0,
                                shape: CircleBorder(),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Theme.of(context).cardColor,
                                    )))
                            : SizedBox(),
                      ),
                      Text(
                        "Thông tin",
                        style: GoogleFonts.comfortaa(
                          textStyle: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => SettingDialog(),
                          );
                        },
                        child: Container(
                            width: 50,
                            child: Icon(
                              Icons.settings,
                              color: Theme.of(context).cardColor,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.circle,
                          size: 6, color: Theme.of(context).cardColor),
                      Icon(Icons.person_pin_circle,
                          size: 15, color: Theme.of(context).cardColor),
                      Icon(Icons.circle,
                          size: 6, color: Theme.of(context).cardColor),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 238, 243, 166),
                        myColor
                      ]),
                    ),
                    child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    widget.user.avatar == null
                                        ? CircleAvatar(
                                            radius: 100,
                                            backgroundColor: myColor,
                                            child: Image.asset(
                                              'assets/pictures/user96px.png',
                                              color: Colors.white,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : CircleAvatar(
                                            radius: 100,
                                            foregroundImage: _userData.avatar !=
                                                        null ||
                                                    _userData != ''
                                                ? MemoryImage(
                                                    base64Decode(toBase64String(
                                                        _userData.avatar)),
                                                  )
                                                : null,
                                          ),
                                    SizedBox(height: 20),
                                    SizedBox(height: 20),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          MyButton(
                                            label: "Máy ảnh",
                                            //width: 120,
                                            icon: Icon(Icons.camera_alt,
                                                color: Colors.white),
                                            onPressed: () async {
                                              final files = await imageHelper
                                                  .pickImageByCamera();
                                              updateAvatar(files,
                                                  _userData.idkh.toString());
                                            },
                                          ),
                                          SizedBox(width: 10),
                                          MyButton(
                                            // width: 120,
                                            label: "Bộ sưu tập",
                                            icon: Icon(Icons.image,
                                                color: Colors.white),
                                            onPressed: () async {
                                              final files = await imageHelper
                                                  .pickImageByGallery();
                                              updateAvatar(files,
                                                  _userData.idkh.toString());
                                            },
                                          )
                                        ]),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          alignment: Alignment.bottomRight,
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: loading
                                ? null
                                : DecorationImage(
                                    image: AssetImage(
                                      'assets/pictures/user96px.png',
                                    ),
                                    colorFilter: ColorFilter.mode(
                                        myColor, BlendMode.srcATop),
                                    fit: BoxFit.cover),
                          ),
                          child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.camera_alt,
                                color: myColor,
                                size: 20,
                              )),
                        )),
                  ),
                  Text(
                    _userData.hoten,
                    style: GoogleFonts.comfortaa(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, size: 20, color: Colors.grey),
                      SizedBox(width: 5),
                      Text(
                        "(+84) ${checkString(_userData.dienthoai).toString().substring(1)}",
                        style: GoogleFonts.comfortaa(
                          textStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      );

  Widget Body(UserData _userData) => Card(
        elevation: 0,
        margin: EdgeInsets.all(20),
        child: Container(
          width: screen(context).width,
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
          // height: 330,

          child: Column(
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: 170),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2.5),
                  children: [
                    ItemInfo(
                      title: "Giới tính",
                      text: checkString(_userData.gioitinh),
                      icon: UniconsLine.mars,
                      color: Colors.red.shade200,
                    ),
                    ItemInfo(
                      title: "Ngày sinh",
                      text: _userData.ngaysinh != ''
                          ? formatDate(_userData.ngaysinh)
                          : formatDate(DateTime.now()),
                      icon: UniconsLine.calendar_alt,
                      color: Color.fromARGB(255, 182, 213, 43),
                    ),
                    ItemInfo(
                      title: "Số BHXH",
                      text: checkString(_userData.mabhxh),
                      icon: UniconsLine.credit_card,
                      color: const Color.fromARGB(255, 106, 202, 246),
                    ),
                    ItemInfo(
                      title: "CCCD/CMND",
                      text: checkString(_userData.cccd),
                      icon: UniconsLine.transaction,
                      color: Color.fromARGB(255, 205, 166, 255),
                    ),
                  ],
                ),
              ),
              Divider(color: myColor.withOpacity(.4), height: 1),
              ItemInfo(
                title: "Nghề nghiệp",
                text: checkString(_userData.nghenghiep),
                icon: UniconsLine.suitcase,
                color: Color.fromARGB(255, 252, 175, 255),
              ),
              ItemInfo(
                title: "Địa chỉ",
                text: "${checkString(_userData.diachi)}",
                icon: UniconsLine.location_point,
                color: Color.fromARGB(255, 116, 231, 170),
              ),
            ],
          ),
        ),
      );
  Widget Bottom(UserData _userData) => Stack(
        children: [
          Container(
            width: screen(context).width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 120,
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: screen(context).width,
              padding: EdgeInsets.all(15),
              height: 120,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Container(
                    width: 220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Thông báo",
                          style: GoogleFonts.comfortaa(
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Text(
                          "Để thay đổi thông tin tài khoản, vui lòng đến bệnh viện để được hỗ trợ.",
                          style: GoogleFonts.comfortaa(
                            textStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Xem đường đi",
                              style: GoogleFonts.comfortaa(
                                textStyle: TextStyle(
                                  color: myColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.location_on,
                              size: 20,
                              color: myColor,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}

// ignore: must_be_immutable
class ItemInfo extends StatelessWidget {
  ItemInfo(
      {super.key,
      required this.title,
      required this.text,
      required this.icon,
      this.color});
  String title;
  String text;
  IconData icon;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: screen(context).width / 2 - 40,
      decoration: BoxDecoration(),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          child: Icon(icon, color: color),
          backgroundColor: Colors.transparent,
        ),
        title: Text(
          title,
          style: GoogleFonts.comfortaa(
            textStyle: TextStyle(
              color: Colors.blueGrey,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        subtitle: Text(text),
      ),
    );
  }
}
