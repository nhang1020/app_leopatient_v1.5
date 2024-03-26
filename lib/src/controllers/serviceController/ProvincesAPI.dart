import 'dart:convert';

import 'package:app/src/models/serviceModel/Province.dart';
import 'package:http/http.dart' as http;

class ProvincesAPI {
  static const host = 'https://provinces.open-api.vn/api/';
  Future<List<Province>> fetchProvinces() async {
    List<Province> list = [];
    try {
      final response = await http.get(
        Uri.parse(host),
      );
      if (response.statusCode == 200) {
        list = provinceFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      print(e);
    }
    return list;
  }

  Future<List<District>> fetchDistricts(int provinceCode) async {
    List<District> list = [];
    try {
      final response = await http.get(
        Uri.parse("${host}p/$provinceCode?depth=2"),
      );
      if (response.statusCode == 200) {
        list = districtFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      print(e);
    }
    return list;
  }

  Future<List<Ward>> fetchWards(int districtCode) async {
    List<Ward> list = [];
    try {
      final response = await http.get(
        Uri.parse("${host}d/$districtCode?depth=2"),
      );
      if (response.statusCode == 200) {
        list = wardFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      print(e);
    }
    return list;
  }
}
