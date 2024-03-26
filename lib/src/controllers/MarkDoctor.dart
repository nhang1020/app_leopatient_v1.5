import 'package:shared_preferences/shared_preferences.dart';

class MarkDoctor {
  static Future<List<String>> getMarkDoctors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getStringList('listMarkDoctor') ?? [];
  }

  static Future markDoctor(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> list = prefs.getStringList('listMarkDoctor') ?? [];
      if (list.contains(id)) {
        list.remove(id);
        prefs.setStringList('listMarkDoctor', list);
      } else {
        prefs.setStringList('listMarkDoctor', list + [id]);
      }
    } catch (e) {
      print(e);
    }
  }
}
