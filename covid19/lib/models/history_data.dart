// To parse this JSON data, do
//
//     final hData = hDataFromJson(jsonString);

import 'dart:convert';

List<HData> hDataFromJson(String str) =>
    List<HData>.from(json.decode(str).map((x) => HData.fromJson(x)));

String hDataToJson(List<HData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HData {
  String country;
  String province;
  Timeline timeline;

  HData({
    this.country,
    this.province,
    this.timeline,
  });

  factory HData.fromJson(Map<String, dynamic> json) => HData(
        country: json["country"],
        province: json["province"] == null ? null : json["province"],
        timeline: Timeline.fromJson(json["timeline"]),
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "province": province == null ? null : province,
        "timeline": timeline.toJson(),
      };
}

class Timeline {
  Map<String, int> cases;
  Map<String, int> deaths;

  Timeline({
    this.cases,
    this.deaths,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) => Timeline(
        cases:
            Map.from(json["cases"]).map((k, v) => MapEntry<String, int>(k, v)),
        deaths:
            Map.from(json["deaths"]).map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "cases": Map.from(cases).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "deaths":
            Map.from(deaths).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
