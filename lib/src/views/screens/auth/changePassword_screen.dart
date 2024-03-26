import 'package:app/src/controllers/DoiMatKhauController.dart';
import 'package:app/src/controllers/localData.dart';
import 'package:app/src/models/DoiMatKhau.dart';
import 'package:app/src/models/TinNhanThongBao.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:app/src/views/widgets/rootWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChangePasswork extends StatefulWidget {
  int idkh;
  bool first;
  ChangePasswork({super.key, required this.idkh, required this.first});

  @override
  State<ChangePasswork> createState() => _ChangePassworkState();
}

class _ChangePassworkState extends State<ChangePasswork> {
  DoiMatKhau output = DoiMatKhau(success: false, message: '');
  InputDoiMatKhau input = InputDoiMatKhau(
      idkh: '', matkhauOld: '', matkhauNew: '', matkhauConfirm: '');
  DoiMatKhauController _doiMatKhauController = DoiMatKhauController();
  OutlineInputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: Colors.transparent),
  );
  LocalData _localData = LocalData();

  final _conOldPasswork = TextEditingController();
  final _conNewPasswork = TextEditingController();
  final _conConfirmPasswork = TextEditingController();

  changePasswork() async {
    setState(() {
      input = InputDoiMatKhau(
          idkh: widget.idkh,
          matkhauOld: _conOldPasswork.text,
          matkhauNew: _conNewPasswork.text,
          matkhauConfirm: _conConfirmPasswork.text);
    });
    output = await _doiMatKhauController.postDoiMatKhau(input);

    showMessage(output);
    if (output.success == true) {
      TinNhanThongBao tb = TinNhanThongBao(
          thoigian: DateTime.now(),
          tieude: 'Hệ thống',
          noidung: 'Bạn đã đổi mật khẩu thành công.');
      _localData.Shared_saveThongBao(tb);
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _old = false;
  bool _new = false;
  bool _confirm = false;
  bool showOld = true;
  bool showNew = true;
  bool showConfirm = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: myColor,
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(-3, 10),
                                      blurRadius: 20,
                                      color: Colors.black26),
                                ]),
                            child: Text(
                              "Xin chào !",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.comfortaa(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 50),
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                color: myColor.withOpacity(.1),
                                // gradient: RadialGradient(
                                //   colors: [
                                //     Colors.red.withOpacity(.2),
                                //     Colors.white.withOpacity(.2)
                                //   ],
                                //   radius: 0.5,
                                // ),
                                shape: BoxShape.circle),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 400,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.green.withOpacity(.1),
                                // gradient: RadialGradient(
                                //   colors: [
                                //     Colors.blue.withOpacity(.3),
                                //     Colors.white.withOpacity(.2)
                                //   ],
                                //   radius: 0.5,
                                // ),
                                shape: BoxShape.circle),
                          ),
                          Container(
                            height: 300,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.green.withOpacity(.1),
                                // gradient: RadialGradient(
                                //   colors: [
                                //     Colors.green.withOpacity(.3),
                                //     Colors.white.withOpacity(.2)
                                //   ],
                                //   radius: 0.5,
                                // ),
                                shape: BoxShape.circle),
                          ),
                        ],
                      ),
                      Container(
                        height: 400,
                        child: Column(
                          children: [
                            Container(
                              height: 250,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/pictures/3Ddoctor.png"),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                widget.first == true
                                    ? "Đây là lần đầu tiên bạn đăng nhập, hãy đổi mật khẩu để an toàn và bảo mật cho tài khoản nhé!"
                                    : "Nhập đầy đủ thông tin bên dưới để đổi mật khẩu.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.comfortaa(
                                  textStyle: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Card(
                    margin: EdgeInsets.all(8),
                    child: Container(
                      padding: EdgeInsets.only(bottom: _old ? 10 : 0),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        // boxShadow: [boxShadows[0]],
                        // border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        obscureText: showOld,
                        controller: _conOldPasswork,
                        decoration: InputDecoration(
                          border: inputBorder,
                          enabledBorder: inputBorder,
                          focusedBorder: inputBorder,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          labelText: 'Mật khẩu cũ',
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                showOld = !showOld;
                              });
                            },
                            child: Icon(CupertinoIcons.eye),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              _old = true;
                            });

                            return 'Vui lòng nhập mật khẩu';
                          }
                          setState(() {
                            _old = false;
                          });

                          return null;
                        },
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(8),
                    child: Container(
                      padding: EdgeInsets.only(bottom: _new ? 10 : 0),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        // boxShadow: [boxShadows[0]],
                        //   border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        obscureText: showNew,
                        controller: _conNewPasswork,
                        decoration: InputDecoration(
                            border: inputBorder,
                            enabledBorder: inputBorder,
                            focusedBorder: inputBorder,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            labelText: 'Mật khẩu mới',
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  showNew = !showNew;
                                });
                              },
                              child: Icon(CupertinoIcons.eye),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              _new = true;
                            });
                            return 'Vui lòng nhập mật khẩu mới';
                          } else if (value.length < 6) {
                            setState(() {
                              _new = true;
                            });
                            return 'Mật khẩu phải nhiều hơn 6 ký tự';
                          }
                          setState(() {
                            _new = false;
                          });
                          return null;
                        },
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(8),
                    child: Container(
                      padding: EdgeInsets.only(bottom: _confirm ? 10 : 0),
                      child: TextFormField(
                        obscureText: showConfirm,
                        controller: _conConfirmPasswork,
                        decoration: InputDecoration(
                            border: inputBorder,
                            enabledBorder: inputBorder,
                            focusedBorder: inputBorder,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            labelText: 'Xác nhận mật khẩu',
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  showConfirm = !showConfirm;
                                });
                              },
                              child: Icon(CupertinoIcons.eye),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              _confirm = true;
                            });
                            return 'Vui lòng xác nhận mật khẩu';
                          } else if (_conNewPasswork.text != value) {
                            setState(() {
                              _confirm = true;
                            });
                            return 'Mật khẩu xác nhận không đúng';
                          }
                          setState(() {
                            _confirm = false;
                          });
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MyButton(
                      width: 200,
                      // radius: 15,
                      // boxShadows: [
                      //   BoxShadow(
                      //     offset: Offset(3, 10),
                      //     blurRadius: 30,
                      //     //   color: Color.fromARGB(255, 176, 209, 186),
                      //   )
                      // ],
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          changePasswork();
                        }
                      },
                      icon: Text(
                        "Xác nhận",
                        style: GoogleFonts.alatsi(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            // fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  MyButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          contentPadding: EdgeInsets.all(10),
                          content: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                    "assets/pictures/questiondoctor.png",
                                    width: 50),
                                Expanded(
                                  child: Container(
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        "Thông báo",
                                        style: TextStyle(
                                            color: myColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        "Bạn có chắc muốn bỏ qua không?",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Hủy'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'OK');
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RootWidget(),
                                    ));
                              },
                              child: const Text('Đồng ý'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Text(
                      "Bỏ qua",
                      style: TextStyle(
                          color: myColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    boxShadows: [],
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                    ],
                    isGradient: true,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showMessage(DoiMatKhau data) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: data.success == true
              ? Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    Text(
                      'Thành công',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              : Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                    Text(
                      'Thất bại',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
          content: Text(data.message),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
                if (data.success == true) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RootWidget(),
                      ));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
