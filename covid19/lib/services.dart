import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:covid19/models/data.dart';

class Services {
  static const url = "https://corona.lmao.ninja/countries";

  static Future<List<Data>> getData() async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<Data> data = dataFromJson(response.body);

        return data;
      } else {
        return List<Data>();
      }
    } catch (e) {
      return List<Data>();
    }
  }
}
