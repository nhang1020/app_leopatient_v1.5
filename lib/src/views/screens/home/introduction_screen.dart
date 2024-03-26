import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/auth/login_screen.dart';

import 'package:app/src/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:animations/animations.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  List<Widget> _listPage = [
    FirstPage(),
    SecondPage(),
    LastPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: 680,
          child: PageView(
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            controller: _pageController,
            children: _listPage,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 100,
              child: Row(
                children: [
                  for (int index = 0; index < _listPage.length; index++)
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                        _pageController.animateToPage(_selectedIndex,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        height: 10,
                        width: _selectedIndex == index ? 30 : 10,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: _selectedIndex == index
                              ? myColor
                              : Colors.black26,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _selectedIndex != _listPage.length - 1 ? 1 : 0,
                  child: MyButton(
                    height: 45,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = _listPage.length - 1;
                      });
                      _pageController.animateToPage(_selectedIndex,
                          duration: Duration(milliseconds: 1),
                          curve: Curves.easeOut);
                    },
                    color: myColor.withOpacity(.2),
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(30)),
                    label: "BỎ QUA",
                    textColor: Colors.teal.shade800,
                  ),
                ),
                OpenContainer(
                  openBuilder: (context, action) => ShowCaseWidget(
                      builder: Builder(
                    builder: (context) => LoginScreen(),
                  )),
                  closedBuilder: (context, action) => AnimatedContainer(
                    alignment: Alignment.center,
                    duration: Duration(milliseconds: 300),
                    width: _selectedIndex == _listPage.length - 1 ? 200 : 0,
                    height: 50,
                    decoration: BoxDecoration(
                      color: myColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onTap: action,
                      child: Text(
                        "BẮT ĐẦU",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  // child:
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _selectedIndex != _listPage.length - 1 ? 1 : 0,
                  child: MyButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = _selectedIndex == _listPage.length - 1
                            ? 0
                            : _selectedIndex + 1;
                      });
                      _pageController.animateToPage(_selectedIndex,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut);
                    },
                    height: 45,
                    color: Colors.teal.shade600,
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(30)),
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Text(
            "Leohis App",
            style: TextStyle(
              color: Colors.teal.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, size: 10, color: myColor),
                SizedBox(width: 5),
                Icon(Icons.circle, size: 15, color: myColor),
                SizedBox(width: 5),
                Icon(Icons.medical_services, color: myColor),
                SizedBox(width: 5),
                Icon(Icons.circle, size: 15, color: myColor),
                SizedBox(width: 5),
                Icon(Icons.circle, size: 10, color: myColor),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 400),
            child: Lottie.asset(
              "assets/images/introduction/Dotor.json",
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "Chào mừng bạn đến với Leohis App",
                  style: TextStyle(
                    color: Colors.teal.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Đăng nhập để sử dụng nhiều tính năng hữu ích hỗ trợ trong công việc bảo vệ sức khỏe",
                    style: TextStyle(
                      color: Colors.teal.shade800,
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
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

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Text(
            "Giới thiệu",
            style: TextStyle(
              color: Colors.teal.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, size: 10, color: myColor),
                SizedBox(width: 5),
                Icon(Icons.circle, size: 15, color: myColor),
                SizedBox(width: 5),
                Icon(Icons.app_registration, color: myColor),
                SizedBox(width: 5),
                Icon(Icons.circle, size: 15, color: myColor),
                SizedBox(width: 5),
                Icon(Icons.circle, size: 10, color: myColor),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 400),
            child: Lottie.asset(
              "assets/images/introduction/MedicalProtect.json",
            ),
          ),
          Expanded(
            child: Column(
              children: [
                // Text(
                //   "Chào mừng bạn đến với Leohis App",
                //   style: TextStyle(
                //     color: Colors.teal.shade800,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 23,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    " Tính năng\n• Xem lịch khám bệnh ✓\n• Tra cứu thông tin, kết quả ✓ \n• Đăng ký thông tin khám, đặt lịch ✓",
                    style: TextStyle(
                      color: Colors.teal.shade800,
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.left,
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

// ignore: must_be_immutable
class LastPage extends StatefulWidget {
  LastPage({super.key});
  @override
  State<LastPage> createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Text(
            "",
            style: TextStyle(
              color: Colors.teal.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, size: 10, color: myColor),
                SizedBox(width: 5),
                Icon(Icons.circle, size: 15, color: myColor),
                SizedBox(width: 5),
                Icon(Icons.app_registration, color: myColor),
                SizedBox(width: 5),
                Icon(Icons.circle, size: 15, color: myColor),
                SizedBox(width: 5),
                Icon(Icons.circle, size: 10, color: myColor),
              ],
            ),
          ),
          Container(
            height: 400,
            child: Lottie.asset("assets/images/introduction/Login.json"),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Chào mừng bạn đến với Leohis App, hãy cùng nhau trải nghiệm những tiện ích mới nào!",
              style: TextStyle(
                  color: Colors.teal.shade700,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
