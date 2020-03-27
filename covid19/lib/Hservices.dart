import 'dart:async';

import 'package:http/http.dart' as http;

import 'models/history_data.dart';

class HistoryServices {
  static const url = "https://corona.lmao.ninja/v2/historical";

  static Future<List<HData>> getData() async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<HData> data = hDataFromJson(response.body);

        return data;
      } else {
        return List<HData>();
      }
    } catch (e) {
      return List<HData>();
    }
  }

  static Future<String> toJson() async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<HData> hdata = hDataFromJson(response.body);

        String jsonString = hDataToJson(hdata);
        return jsonString;
      } else {
        return "null";
      }
    } catch (e) {
      return "List<HData>()";
    }
  }
}
