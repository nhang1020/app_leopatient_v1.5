import 'package:http/http.dart' as http;
import 'dart:convert';

class FCMController {
  static Future<void> sendNotification({
    required String receiverToken,
    String title = "",
    String body = "",
    bool schedule = false,
    DateTime? time,
  }) async {
    // Tạo HTTP request đến FCM endpoint
    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAA3CiiBGI:APA91bF2voBF-Plrdvw8IiDELL5ekjM37lJxRtplfF74sVtDCHMNflPNcQaVqmej7CQDG4wHhCoIZQgpAT0xEcc_IKMuOC_ePfic1uPKDJIVqkHf5zG8Tux1T3Emf_35ne_Il9BQ1yFV',
      },
      body: jsonEncode(
        <String, dynamic>{
          'data': <String, dynamic>{
            'title': title,
            'body': body,
            'schedule': schedule,
            'time': time != null ? time.millisecondsSinceEpoch : ""
          },
          'to': receiverToken, // "to": "/topics/ALL",
        },
      ),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully!');
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
    }
  }
}
