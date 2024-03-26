import 'dart:convert';

import 'package:flutter/services.dart';

class Utils {
  static Future<String> convertToBase64(String assetImage) async {
    try {
      ByteData bytes = await rootBundle.load(assetImage);
      var buffer = bytes.buffer;
      return base64Encode(
          buffer.asUint8List()); //base64.encode(Uint8List.view(buffer));
    } catch (e) {
      print(e);
      return "";
    }
  }
}
