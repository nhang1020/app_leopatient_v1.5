import 'package:app/src/controllers/localData.dart';
import 'package:app/src/controllers/notification_manager/notification_helper.dart';
import 'package:app/src/utils/theme.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/auth/changePassword_screen.dart';
import 'package:app/src/views/screens/auth/login_screen.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingDialog extends StatefulWidget {
  const SettingDialog({super.key});

  @override
  State<SettingDialog> createState() => _SettingDialogState();
}

class _SettingDialogState extends State<SettingDialog> {
  int _selectedIndex = 0;
  LocalData _localData = LocalData();
  int idkh = 0;
  int _themeMode = 0;
  void readTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? indexTheme = await prefs.getInt('theme');
    int? indexMode = await prefs.getInt('themeMode');
    setState(() {
      _selectedIndex = indexTheme ?? 0;
      _themeMode = indexMode ?? 0;
    });
  }

  readID() async {
    idkh = await _localData.Shared_getID();
    setState(() {
      idkh;
    });
  }

  @override
  void initState() {
    super.initState();
    readTheme();
    readID();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    List<Color> listColors =
        provider.isDarkMode || provider.isSysDark ? darkThemes : lightThemes;
    return Center(
      child: AlertDialog(
        backgroundColor: Theme.of(context).canvasColor,
        shadowColor: Colors.black26,
        elevation: 10,
        // buttonPadding: EdgeInsets.zero,
        title: Row(
          children: [
            Icon(Icons.settings),
            Text(" Cài đặt", style: TextStyle()),
          ],
        ),
        content: SingleChildScrollView(
          child: Container(
            // constraints: BoxConstraints(minHeight: 200),
            width: screen(context).width / 1.2,
            // constraints: BoxConstraints(maxWidth: 400),
            // height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  child: Column(
                    children: [
                      DividerTitle(title: "Tài khoản"),
                      Container(
                        child: MyButton(
                          label: 'Đổi mật khẩu',
                          color: Colors.transparent,
                          textColor: myColor,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePasswork(
                                    idkh: idkh,
                                    first: false,
                                  ),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Theme.of(context).canvasColor,
                  child: Column(
                    children: [
                      DividerTitle(title: "Chủ đề"),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: [
                              for (int index = 0;
                                  index < listColors.length;
                                  index++)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                    provider.toggleColor(index,
                                        context: context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: listColors[index],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: _selectedIndex == index
                                        ? Icon(Icons.check_circle,
                                            size: 20,
                                            color: Theme.of(context).cardColor)
                                        : null,
                                  ),
                                ),
                            ]),
                      ),
                      Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        // elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              backgroundColor: myColor,
                              child: Icon(Icons.person,
                                  color: Theme.of(context)
                                      .cardColor
                                      .withOpacity(.5)),
                            ),
                            title: Container(
                              margin: EdgeInsets.only(bottom: 5),
                              height: 10,
                              width: 50,
                              decoration: BoxDecoration(
                                color: myColor,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 3),
                                  height: 10,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: myColor.withOpacity(.15)),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 3),
                                  height: 10,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: listColors[_selectedIndex]
                                          .withOpacity(.15)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      DividerTitle(title: "Giao diện"),
                      RadioListTile(
                        activeColor: myColor,
                        title: Row(
                          children: [
                            Text("Hệ thống   "),
                            Icon(Icons.phone_android, color: myColor)
                          ],
                        ),
                        value: 0,
                        groupValue: _themeMode,
                        onChanged: (value) {
                          setState(() {
                            _themeMode = value!;
                          });
                          provider.toggleTheme(value!, _selectedIndex, context);
                        },
                      ),
                      RadioListTile(
                        activeColor: myColor,
                        title: Row(
                          children: [
                            Text("Nền sáng  "),
                            Icon(Icons.brightness_7, color: myColor)
                          ],
                        ),
                        value: 1,
                        groupValue: _themeMode,
                        onChanged: (value) {
                          setState(() {
                            _themeMode = value!;
                          });
                          provider.toggleTheme(value!, _selectedIndex, context);
                        },
                      ),
                      RadioListTile(
                        activeColor: myColor,
                        title: Row(
                          children: [
                            Text("Nền tối      "),
                            Icon(Icons.brightness_4_outlined, color: myColor)
                          ],
                        ),
                        value: 2,
                        groupValue: _themeMode,
                        onChanged: (value) {
                          setState(() {
                            _themeMode = value!;
                          });
                          provider.toggleTheme(value!, _selectedIndex, context);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                MyButton(
                  onPressed: () async {
                    try {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();
                      await NotificationHelper.cancelAll();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    } catch (e) {
                      print(e);
                    }
                  },
                  label: "Đăng xuất",
                  color: myColor,
                  subfixIcon:
                      Icon(Icons.logout, color: Theme.of(context).cardColor),
                )
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
              child: Text("Ok", style: TextStyle(color: myColor)),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
