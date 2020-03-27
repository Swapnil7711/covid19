import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_charts/multi_charts.dart';
import 'gobal.dart';
// import 'country.dart';
import 'map.dart';
import 'test.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var authResponseData,
      chinaPer,
      italyPer,
      usaPer,
      spainPer,
      otherPer,
      allTotalCases;
  var countryWiseData;

  bool isLoading = true;
  bool chartLoading = true;

  var dates, cases, countries, allHData;

  // Future getData() async {
  //   var mapData;
  //   List dates1 = [];
  //   List cases1 = [];
  //   List countries1 = [];
  //   String allDataUrl = "https://corona.lmao.ninja/historical";
  //   var response = await http.get(allDataUrl);
  //   mapData = json.decode(response.body);

  //   print("map data is: $mapData");

  //   // var d = (mapData[0]['timeline']['cases'].keys).toList();

  //   // // if (d is List) {
  //   // //   print("type is list: $d");
  //   // // } else {
  //   // //   print("wrong type");
  //   // // }

  //   print("null values : ${(mapData[0]['timeline']['cases'])}");

  //   // all in one list
  //   var allHData1 = [];
  //   for (var i = 0; i < mapData.length; i++) {
  //     allHData.add("cases", mapData[i]['timeline']['cases']);
  //   }

  //   //  separete vales for dates, values, and counrty name

  //   for (var i = 0; i < mapData.length; i++) {
  //     dates1.add((mapData[i]['timeline']['cases'].keys).toList());

  //     cases1.add((mapData[i]['timeline']['cases'].values).toList());

  //     countries1.add((mapData[i]['country']));
  //   }
  //   setState(() {
  //     this.dates = dates1;
  //     this.cases = cases1;
  //     this.countries = countries1;
  //     this.allHData = allHData1;

  //     print("dates are $dates");
  //     print("values are :$cases");
  //   });
  // }

  Future allData() async {
    String allDataUrl = "https://corona.lmao.ninja/all";

    var response = await http.get(allDataUrl);
    var data = json.decode(response.body);

    setState(() {
      this.authResponseData = data;
      // this.countryWiseData = data1;
      isLoading = false;
    });

    // percentageData();
    this.countryData();
  }

  Future countryData() async {
    String url = "https://corona.lmao.ninja/countries";
    var response = await http.get(url);
    var data = json.decode(response.body);
    setState(() {
      this.countryWiseData = data;
      this.allHData = data;
      chartLoading = false;
    });
    percentageData();
  }

  void percentageData() {
    var totalCases = authResponseData['cases'];
    print("total cases: $totalCases");
    var chinaData =
        ((countryWiseData[0]['cases'] / totalCases) * 100).roundToDouble();

    print("china Per: $chinaData");

    var italyData =
        ((countryWiseData[1]['cases'] / totalCases) * 100).roundToDouble();

    print("Italy Per: $italyData");

    var usaData =
        ((countryWiseData[2]['cases'] / totalCases) * 100).roundToDouble();

    print("Usa Per: $usaData");

    var spainData =
        ((countryWiseData[3]['cases'] / totalCases) * 100).roundToDouble();

    print("india Per: $spainData");

    var otherAddition = (countryWiseData[0]['cases']) +
        (countryWiseData[1]['cases']) +
        (countryWiseData[2]['cases']) +
        (countryWiseData[3]['cases']);

    var othercases = ((totalCases) - otherAddition);

    var otherCasesPer = ((othercases / totalCases) * 100).roundToDouble();

    var totalPer = chinaData + italyData + usaData + spainData + otherCasesPer;

    if (totalPer < 100) {
      var addper = 100 - totalPer;

      otherCasesPer += addper;
    } else {
      var addper = totalPer - 100;

      otherCasesPer -= addper;
    }

    print("other Per: $otherCasesPer");

    setState(() {
      allTotalCases = totalCases;
      chinaPer = chinaData;
      italyPer = italyData;
      usaPer = usaData;
      spainPer = spainData;
      otherPer = otherCasesPer;
    });
  }

  @override
  void initState() {
    super.initState();
    this.allData();
    // this.getData();
    // this.countryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid 19"),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Container(
                margin: EdgeInsets.fromLTRB(10, 50, 10, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "World Wide Data",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Total Cases",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(height: 10),
                                      Text(authResponseData['cases'].toString(),
                                          style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Deaths",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                          authResponseData['deaths'].toString(),
                                          style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Recovered",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                          authResponseData["recovered"]
                                              .toString(),
                                          style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 120,
                    ),
                    chartLoading
                        ? CircularProgressIndicator()
                        : PieChart(
                            //  works only with percetange data
                            values: [
                              chinaPer,
                              italyPer,
                              usaPer,
                              spainPer,
                              otherPer
                            ],
                            labels: ["China", "Itely", "USA", "Spain", "Other"],
                            sliceFillColors: [
                              Colors.blueAccent,
                              Colors.greenAccent,
                              Colors.pink,
                              Colors.orange,
                              Colors.red,
                            ],
                            animationDuration: Duration(milliseconds: 1500),

                            startAngle: 90,
                          ),
                    SizedBox(height: 150),
                    MaterialButton(
                      height: 40.0,
                      minWidth: 100.0,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: new Text(
                        "See Country Wise Data",
                        style: mainText,
                      ),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Country(
                                // data: countryWiseData,
                                // dates: dates,
                                // cases: cases,
                                // countries: countries,
                                // allHData: allHData,
                                ),
                          ),
                        ),
                      },
                      splashColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
