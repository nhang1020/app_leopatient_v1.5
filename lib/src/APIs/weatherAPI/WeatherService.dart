// import 'dart:convert';

// import 'package:app/src/APIs/weatherAPI/Weather.dart';
// import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// class WeatherService {
//   static const BASE_URL = "https://api.openweathermap.org/data/3.0/weather";

//   // final String apiKey;

//   // WeatherService({required this.apiKey});
//   final String apiKey = "075db6ae9365fbad778b4e4d9c187dda";
//   Future<Weather> getWeather(String cityName) async {
//     final response = await http
//         .get(Uri.parse('$BASE_URL?q=$cityName&appaid=$apiKey&units=metric'));

//     if (response.statusCode == 200) {
//       return Weather.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception("Failed");
//     }
//   }

//   Future<String> getCurrentCity() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }

//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);

//     List<Placemark> placeMarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);

//     String? city = placeMarks[0].locality;
//     return city ?? "";
//   }
// }
