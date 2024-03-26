// To parse this JSON data, do
//
//     final province = provinceFromJson(jsonString);

import 'dart:convert';

List<Province> provinceFromJson(String str) =>
    List<Province>.from(json.decode(str).map((x) => Province.fromJson(x)));

String provinceToJson(List<Province> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Province {
  String name;
  int code;
  String divisionType;
  String codename;
  int phoneCode;
  List<District> districts;

  Province({
    required this.name,
    required this.code,
    required this.divisionType,
    required this.codename,
    required this.phoneCode,
    required this.districts,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        name: json["name"],
        code: json["code"],
        divisionType: json["division_type"],
        codename: json["codename"],
        phoneCode: json["phone_code"],
        districts: List<District>.from(
            json["districts"].map((x) => District.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "division_type": divisionType,
        "codename": codename,
        "phone_code": phoneCode,
        "districts": List<dynamic>.from(districts.map((x) => x.toJson())),
      };
}

List<District> districtFromJson(String str) => Province.fromJson(jsonDecode(str)).districts;

class District {
  String name;
  int code;
  String divisionType;
  String codename;
  int provinceCode;
  List<Ward> wards;

  District({
    required this.name,
    required this.code,
    required this.divisionType,
    required this.codename,
    required this.provinceCode,
    required this.wards,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
        name: json["name"],
        code: json["code"],
        divisionType: json["division_type"],
        codename: json["codename"],
        provinceCode: json["province_code"],
        wards: List<Ward>.from(json["wards"].map((x) => Ward.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "division_type": divisionType,
        "codename": codename,
        "province_code": provinceCode,
        "wards": List<dynamic>.from(wards.map((x) => x.toJson())),
      };
}


List<Ward> wardFromJson(String str) => District.fromJson(jsonDecode(str)).wards;
class Ward {
  String name;
  int code;
  String divisionType;
  String codename;
  int districtCode;

  Ward({
    required this.name,
    required this.code,
    required this.divisionType,
    required this.codename,
    required this.districtCode,
  });

  factory Ward.fromJson(Map<String, dynamic> json) => Ward(
        name: json["name"],
        code: json["code"],
        divisionType: json["division_type"],
        codename: json["codename"],
        districtCode: json["district_code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "division_type": divisionType,
        "codename": codename,
        "district_code": districtCode,
      };
}
