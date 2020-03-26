import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryData {
  String url;

  HistoryData(this.url);

  var dates, cases, countries, allHData;

  Future getData() async {
    List mapData;
    List dates1 = [];
    List cases1 = [];
    List countries1 = [];
    String allDataUrl = url;
    Map<String, dynamic> allHData = Map<String, dynamic>();
    var response = await http.get(allDataUrl);
    mapData = json.decode(response.body);

    print("map data is: $mapData");

    // // all in one list
    // for (var i = 0; i < mapData.length; i++) {
    //   allHData.addAll((mapData[i])['timeline']);
    // }

    //  separete vales for dates, values, and counrty name

    // for (var i = 0; i < mapData.length; i++) {
    //   dates1.add((mapData[i]['timeline']['cases'].keys).toList());

    //   cases1.add((mapData[i]['timeline']['cases'].values).toList());

    //   countries1.add((mapData[i]['country']));
    // }

    // allHData.addAll(dates1);
    // allHData.addAll(cases1);
    // allHData.addAll(countries1);
    return mapData;
  }
}
