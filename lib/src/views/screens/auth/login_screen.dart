import 'dart:convert';

import 'package:app/src/controllers/DangNhapController.dart';
import 'package:app/src/controllers/localData.dart';
import 'package:app/src/models/User_Pass.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/controllers/notification_manager/notification_helper.dart';
import 'package:app/src/views/screens/auth/second_device.dart';
import 'package:app/src/views/widgets/button.dart';
// import 'package:app/src/views/widgets/rootPage.dart';
import 'package:flutter/material.dart';

import 'package:unicons/unicons.dart';
import '../../widgets/text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Color color = Color(0xFF2185D0);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = screen(context).width < 800;

    return Scaffold(
      body: SingleChildScrollView(
        child: Ink(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(),
          child: Stack(
            // alignment: Alignment.center,
            children: [
              Container(
                // margin: EdgeInsets.only(bottom: 50, left: 50),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                      // bottomLeft: Radius.circular(100),
                      ),
                ),
                child: Center(
                  child: isSmallScreen
                      ? SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _Logo(),
                              _FormContent(),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            constraints: const BoxConstraints(maxWidth: 800),
                            child: Row(
                              children: [
                                Expanded(child: _Logo()),
                                Expanded(
                                  child: _FormContent(),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 15),
                alignment: Alignment.bottomCenter,
                height: screen(context).height,
                width: screen(context).width - 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bạn chửa biết cách đăng nhập?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 10),
                    MyButton(
                      onPressed: () {
                        // WidgetsBinding.instance.addPostFrameCallback(
                        //     (timeStamp) => ShowCaseWidget.of(context)
                        //         .startShowCase(
                        //             [globalKey1, globalKey2, globalKey3]));
                      },
                      padding: EdgeInsets.zero,
                      textColor: myColor,
                      height: 30,
                      label: "Hướng dẫn",
                      color: Theme.of(context).cardColor,
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

List<String> hospitals = [
  "Bệnh viện đa khoa An Giang",
  "Bệnh viện Hạnh Phúc",
  "Bệnh viên Phụ Sản An Giang",
];

class _Logo extends StatefulWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  State<_Logo> createState() => _LogoState();
}

class _LogoState extends State<_Logo> {
  String hospitalName = 'Chọn bệnh viện';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                radius: 25,
                padding: EdgeInsets.zero,
                color: myColor.withOpacity(.1),
                textColor: myColor,
                label: hospitalName,
                onPressed: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (context) => AlertDialog(
                  //     content: Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: hospitals
                  //           .map(
                  //             (e) => InkWell(
                  //               onTap: () {
                  //                 Navigator.of(context).pop(e);
                  //               },
                  //               child: Chip(
                  //                 label: Text(e),
                  //               ),
                  //             ),
                  //           )
                  //           .toList(),
                  //     ),
                  //   ),
                  // ).then((value) {
                  //   if (value != null) {
                  //     setState(() {
                  //       hospitalName = value;
                  //     });
                  //   }
                  // });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondDevice(),
                      ));
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Image.asset(
            "assets/pictures/login.png",
            // width: 300,
          ),
          SizedBox(height: 10),
          RichText(
            text: TextSpan(
              text: "Chào mừng đến với ",
              style: TextStyle(color: Colors.grey),
              children: [
                WidgetSpan(
                  child: GradientText(
                    "Leohis App",
                    gradient: LinearGradient(
                      colors: [myColor, Colors.lightBlueAccent],
                    ),
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

// GlobalKey globalKey1 = GlobalKey();
// GlobalKey globalKey2 = GlobalKey();
// GlobalKey globalKey3 = GlobalKey();

class __FormContentState extends State<_FormContent> {
  //

  LocalData _localData = LocalData();
  bool _isPasswordVisible = false;
  bool _rememberMe = true;
  bool isPasswordNull = false;
  bool isUsernameNull = false;
  User_Pass? user_pass =
      User_Pass(userName: '', passWork: '', toKen: '', idkh: 0);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _tenDangNhap = TextEditingController();
  final _matKhau = TextEditingController();
  bool loading = false;

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  );

  bool isLogin = false;
  DangNhapController dangNhapController = DangNhapController();

  @override
  void initState() {
    super.initState();
    // continueLogin();
  }

  listenNotification() =>
      NotificationHelper.onNotification.stream.listen(onClickedNotification);
  onClickedNotification(String? payload) {
    if (payload != null && payload != "") {
      return Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("$payload")],
            ),
          ),
        ),
      ));
    }
  }

  handleLogin() async {
    setState(() {
      loading = true;
    });
    try {
      await dangNhapController.handleLogin(
          _tenDangNhap.text, _matKhau.text, _rememberMe, context);
    } catch (e) {
    } finally {
      try {
        setState(() {
          loading = false;
        });
      } catch (e) {}
    }
  }

  continueLogin() async {
    try {
      user_pass = await _localData.Shared_GetAccount();
      if (user_pass != null) {
        setState(() {
          _tenDangNhap.text = user_pass!.userName;
          _matKhau.text = user_pass!.passWork;
        });

        listenNotification();
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => RootPage(),
        //     ));
      }
    } catch (e) {
      String json = jsonEncode(user_pass);
      _localData.Shared_SaveAccount(json);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Ink(
        width: 370,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      GradientText(
                        'Đăng nhập',
                        gradient: LinearGradient(colors: [
                          myColor,
                          Colors.lightBlueAccent,
                        ]),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.only(bottom: isUsernameNull ? 10 : 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      controller: _tenDangNhap,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Tên đăng nhập',
                        hintText: 'Tên đăng nhập',
                        prefixIcon: Icon(UniconsLine.user),
                        border: outlineInputBorder,
                        enabledBorder: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        errorBorder: outlineInputBorder,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            isUsernameNull = true;
                          });
                          return 'Tên đăng nhập trống';
                        }
                        setState(() {
                          isUsernameNull = false;
                        });
                        return null;
                      },
                    ),
                  ),
                ),
                _gap(),
                Card(
                  margin: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.only(bottom: isPasswordNull ? 10 : 0),
                    child: TextFormField(
                      controller: _matKhau,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                          hintText: 'Mật khẩu',
                          prefixIcon: Icon(UniconsLine.lock),
                          border: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          errorBorder: outlineInputBorder,
                          suffixIcon: IconButton(
                            icon: Icon(
                              !_isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: myColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            isPasswordNull = true;
                          });
                          return 'Vui lòng nhập mật khẩu';
                        }
                        setState(() {
                          isPasswordNull = false;
                        });
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                " Lưu đăng nhập",
                                style: TextStyle(
                                  color: _rememberMe ? myColor : Colors.black45,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Switch(
                                value: _rememberMe,
                                activeColor: myColor,
                                onChanged: (value) {
                                  // ignore: unnecessary_null_comparison
                                  if (value == null) return;
                                  setState(() {
                                    _rememberMe = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          MyButton(
                            icon: loading
                                ? Container(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context).cardColor,
                                    ))
                                : Icon(Icons.login_sharp,
                                    color: Theme.of(context).cardColor),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                handleLogin();
                              }
                            },
                            label: loading ? "" : "ĐĂNG NHẬP",
                            width: 150,
                            radius: 25,

                            // isGradient: true,
                          ),
                        ],
                      ),
                      RotatedBox(
                        quarterTurns: 1,
                        child: GradientText(
                          gradient:
                              LinearGradient(colors: [myColor, Colors.blue]),
                          'LEOHIS',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
