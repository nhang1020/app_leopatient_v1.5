import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/src/APIs/routes.dart';
import 'package:app/src/controllers/localData.dart';

class ThanhToanController {
  APIs _api = APIs();
  LocalData localData = LocalData();

  Future<TTOutput> postXacNhanThanhToan(TTInput input) async {
    TTOutput out = TTOutput(success: false);
    try {
      String token = await localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_XacNhanThanhToan()),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "madangky": '${input.madangky}',
          "phuongthuc_thanhtoan": "${input.phuongthucThanhtoan}",
        },
      );
      out = TTOutput.fromJson(jsonDecode(response.body));
      return out;
    } catch (e) {
      print(e);
    }
    return out;
  }
}

TTOutput TTOutputFromJson(String str) => TTOutput.fromJson(json.decode(str));

String TTOutputToJson(TTOutput data) => json.encode(data.toJson());

class TTOutput {
  bool success;
  dynamic message;
  dynamic data;

  TTOutput({
    required this.success,
    this.message,
    this.data,
  });

  factory TTOutput.fromJson(Map<String, dynamic> json) => TTOutput(
        success: json["success"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}

TTInput TTInputFromJson(String str) => TTInput.fromJson(json.decode(str));

String TTInputToJson(TTInput data) => json.encode(data.toJson());

class TTInput {
  dynamic madangky;
  dynamic phuongthucThanhtoan;
  dynamic tienthanhtoan;

  TTInput({this.madangky, this.phuongthucThanhtoan, this.tienthanhtoan});

  factory TTInput.fromJson(Map<String, dynamic> json) => TTInput(
      madangky: json["madangky"],
      phuongthucThanhtoan: json["phuongthuc_thanhtoan"],
      tienthanhtoan: json["tienthanhtoan"]);

  Map<String, dynamic> toJson() => {
        "madangky": madangky,
        "phuongthuc_thanhtoan": phuongthucThanhtoan,
        "tienthanhtoan": tienthanhtoan
      };
}
