import 'package:flutter/material.dart';
import 'package:covid19/models/history_data.dart';
import 'package:covid19/Hservices.dart';

class MapChart extends StatefulWidget {
  final country;
  final index;

  const MapChart({Key key, this.country, this.index}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapChart> {
  List<HData> hdata;
  bool isLoading;

  List cases = [];
  List deaths = [];

  @override
  void initState() {
    super.initState();
    isLoading = true;
    HistoryServices.getData().then((k) {
      setState(() {
        hdata = k;
        isLoading = false;
      });
    });
  }

  // createData() {
  //   var years = hdata.timeline.cases.keys;

  //   var cases = hdata[widget.index].timeline.cases.values;

  //   print("yers : $years");
  //   print("cases : $cases");
  // }

  // createData() {
  //   var dead, cs;
  //   if (hdata != null) {
  //     for (var item in hdata) {
  //       if (item.country == widget.country) {
  //         var years = item.timeline.cases.values;

  //         print(years);
  //       }
  //     }

  //     setState(() {
  //       cases.addAll(cs);
  //       deaths.addAll(dead);

  //       print("cases are : $cases");
  //       print("deaths are : $deaths");
  //     });
  //   } else {
  //     print("hdata is null : $hdata");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Country Map"),
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Container(
                  child: RaisedButton(
                    onPressed: () {
                      print("country is : ${widget.country}");

                      // createData();
                    },
                  ),
                ),
        ));
  }
}

class LC {
  var year;
  var value;

  LC(this.year, this.value);
}
