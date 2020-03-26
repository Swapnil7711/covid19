import 'package:flutter/material.dart';
import 'map.dart';
import 'history_data.dart';

class Country extends StatefulWidget {
  final data;
  final dates;
  final cases;
  final countries;
  final allHData;

  Country({
    Key key,
    @required this.data,
    this.dates,
    this.cases,
    this.countries,
    this.allHData,
  }) : super(key: key);

  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  TextEditingController editingController = TextEditingController();
  List data;
  List data1;
//  search function

  void filterSearchResults(String query) {
    List<dynamic> dummySearchList = List<dynamic>();

    List<dynamic> dummyList = List<dynamic>();
    dummySearchList.addAll(data);
    print("dummy sreach List : $dummySearchList");

    if (query.isNotEmpty) {
      for (var i = 0; i < data.length; i++) {
        var keys = data[i].keys.toList();

        var val = data[i][keys[0]];

        print("val is: ${val.toLowerCase()}");

        if (val.toLowerCase().contains((query.toLowerCase()))) {
          dummyList.add(data[i]);

          print("dummy list is : $dummyList");
        }
      }
      setState(() {
        print("if set");
        data.clear();
        data.addAll(dummyList);
        print("data1 : $data");
      });

      // return;
    } else {
      print("else started");
      setState(
        () {
          data = [];
          print("CLEAR DATA : $data");
          print('original data: ${widget.data}');
          data.addAll(data1); //this is where the problem is..
          print('else data1: $data');
          print("else ended");
        },
      );
    }
  }

  // void setData1() {
  //   setState(() {
  //     this.data = this.widget.data;
  //     print("set data : $data1");
  //   });
  // }

  @override
  void initState() {
    super.initState();
    setState(() {
      this.data = widget.data;
      this.data1 = widget.data;
      print("init state started dta1: $data1");
    });
    print("init state started");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid 19"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
            TextField(
              // controller: editingController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              onChanged: (value) {
                filterSearchResults(value);
              },
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
            Expanded(
              child: ListView.builder(
                itemCount: widget.data.length,
                itemBuilder: (context, index) {
                  Padding(padding: EdgeInsets.fromLTRB(8, 5, 8, 5));
                  return GestureDetector(
                    onTap: () {
                      var url = "https://corona.lmao.ninja/historical";
                      HistoryData hd = HistoryData(url);
                      hd.getData().then((val) {
                        var data = val;

                        print("country data: $data");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Map(
                              data: data,
                            ),
                          ),
                        );
                      });
                    },
                    child: Card(
                      margin: EdgeInsets.only(top: 10),
                      elevation: 10,
                      borderOnForeground: true,
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                            ),
                            Container(
                              color: Colors.grey,
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(
                                        widget.data[index]['countryInfo']
                                            ['flag'],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      widget.data[index]['country'],
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(top: 10),
                            // ),
                            Container(
                              color: Colors.grey,
                              height: 2,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Table(
                              border: TableBorder.all(
                                  width: 1.0, color: Colors.black),
                              children: [
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text("Cases",
                                              style: TextStyle(fontSize: 20)),
                                          Text(
                                            widget.data[index]['cases']
                                                .toString(),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TableCell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text("Deaths",
                                              style: TextStyle(fontSize: 20)),
                                          Text(
                                              widget.data[index]['deaths']
                                                  .toString(),
                                              style: TextStyle(fontSize: 20)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text("Active",
                                              style: TextStyle(fontSize: 20)),
                                          Text(
                                              widget.data[index]['active']
                                                  .toString(),
                                              style: TextStyle(fontSize: 20)),
                                        ],
                                      ),
                                    ),
                                    TableCell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text("Recovered",
                                              style: TextStyle(fontSize: 20)),
                                          Text(
                                              widget.data[index]['recovered']
                                                  .toString(),
                                              style: TextStyle(fontSize: 20)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text("Critical",
                                              style: TextStyle(fontSize: 20)),
                                          Text(
                                              widget.data[index]['critical']
                                                  .toString(),
                                              style: TextStyle(fontSize: 20)),
                                        ],
                                      ),
                                    ),
                                    TableCell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text("TodayCases",
                                              style: TextStyle(fontSize: 20)),
                                          Text(
                                              widget.data[index]['todayCases']
                                                  .toString(),
                                              style: TextStyle(fontSize: 20)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text("TodayDeaths",
                                              style: TextStyle(fontSize: 20)),
                                          Text(
                                              widget.data[index]['todayDeaths']
                                                  .toString(),
                                              style: TextStyle(fontSize: 20)),
                                        ],
                                      ),
                                    ),
                                    TableCell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text("PerOneMillion",
                                              style: TextStyle(fontSize: 20)),
                                          Text(
                                              widget.data[index]
                                                      ['casesPerOneMillion']
                                                  .toString(),
                                              style: TextStyle(fontSize: 20)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
