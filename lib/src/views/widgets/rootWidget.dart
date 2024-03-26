import 'package:app/src/controllers/BacSiController.dart';
import 'package:app/src/controllers/UserController.dart';
import 'package:app/src/controllers/localData.dart';
import 'package:app/src/models/BacSi.dart';
import 'package:app/src/models/User.dart';
import 'package:app/src/utils/theme.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/explore/explore_screen.dart';
import 'package:app/src/views/screens/home/dashboard.dart';
import 'package:app/src/views/screens/userInfo_screen.dart';
import 'package:app/src/views/widgets/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';
import 'package:animations/animations.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

class RootWidget extends StatefulWidget {
  const RootWidget({super.key});

  @override
  State<RootWidget> createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  int _selectedIndex = 0;
  UserData _userData = initUser;
  LocalData local = LocalData();
  UserController _userController = UserController();

  List<BacSiData> _lstBacSi = [];
  BacSiController _bacSiController = BacSiController();
  bool loading = false;

  loadData() async {
    try {
      loading = true;
      print('${loading}');
      _lstBacSi = await _bacSiController.getBacSi('', '');
      // List<BacSiData> listTmp = _lstBacSi;
      // listTmp.sort((a, b) => b.luotdanhgia.compareTo(a.luotdanhgia));
      setState(() {
        _lstBacSi;
      });
    } catch (e) {
    } finally {
      loading = false;
      print('${loading}');
    }
  }

  Future getUser() async {
    _userData = await _userController.getUser();
    setState(() {
      _userData;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = [
      loading
          ? Loading()
          : DashboardScreen(
              listBacSi: _lstBacSi,
            ),
      ExploreScreen(
        idkh: _userData.idkh,
        listBacSi: _lstBacSi,
      ),
      UserInfo_Screen(loadUserData: loadData, user: _userData),
    ];
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: screen(context).height,
            width: screen(context).width,
            child: PageTransitionSwitcher(
              transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
                return FadeThroughTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                );
              },
              child: Container(
                key: ValueKey<int>(_selectedIndex),
                child: _widgets[_selectedIndex],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(2, 5),
                    blurRadius: 12,
                    color: provider.isDarkMode || provider.isSysDark
                        ? Colors.black12
                        : Colors.black.withOpacity(.06)),
              ],
            ),
            child: CurvedNavigationBar(
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              // buttonBackgroundColor: myColor,
              color: Theme.of(context).cardColor,
              height: 65,
              items: [
                CurvedNavigationBarItem(
                    child: Icon(UniconsLine.estate,
                        color: _selectedIndex == 0 ? myColor : Colors.grey),
                    label: _selectedIndex != 0 ? "Trang chủ" : null,
                    labelStyle: TextStyle(color: Colors.grey)),
                CurvedNavigationBarItem(
                    child: Icon(UniconsLine.search,
                        color: _selectedIndex == 1 ? myColor : Colors.grey),
                    label: _selectedIndex != 1 ? "Tìm kiếm" : null,
                    labelStyle: TextStyle(color: Colors.grey)),
                CurvedNavigationBarItem(
                    child: Icon(UniconsLine.user,
                        color: _selectedIndex == 2 ? myColor : Colors.grey),
                    label: _selectedIndex != 2 ? "Tài khoản" : null,
                    labelStyle: TextStyle(color: Colors.grey)),
              ],
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              letIndexChange: (value) => true,
            ),
          ),
        ],
      ),
    );
  }
}
