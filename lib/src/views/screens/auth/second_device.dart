import 'package:app/src/controllers/notification_manager/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondDevice extends StatelessWidget {
  const SecondDevice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: () async {
                // FCMController.sendNotification(
                //   receiverToken: "${deviceToken}",
                //   title: 'Thông báo',
                //   body: 'Đăng ký lịch khám thành công!',
                // );
                NotificationHelper.simpleNotification(
                  id: 1,
                  title: "ád",
                  body: "Hello máy",
                );
              },
              child: Text("Gửi thông báo"),
            ),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                print(prefs.getString("messageToken"));
              },
              child: Text("Hủy thông báo"),
            )
          ],
        ),
      ),
    );
  }
}
