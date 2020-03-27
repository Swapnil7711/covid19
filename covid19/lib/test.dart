import 'package:covid19/services.dart';
import 'package:flutter/material.dart';
import 'package:covid19/models/data.dart';
import 'map.dart';

class Country extends StatefulWidget {
  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  TextEditingController editingController = TextEditingController();

  List<Data> data1, data, index;
  bool isLoading;

  var country;

  @override
  void initState() {
    super.initState();
    isLoading = true;

    Services.getData().then((u) {
      setState(() {
        data1 = u;
        data = u;
        isLoading = false;
      });
    });
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: editingController,
                      decoration: InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                      onChanged: (value) {
                        // filterSearchResults(value);

                        setState(() {
                          data1 = data
                              .where((u) => u.country
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: data1 == null ? 0 : data1.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Padding(padding: EdgeInsets.fromLTRB(8, 5, 8, 5));
                          return GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapChart(
                                    country: data1[index].country,
                                    index: index,
                                  ),
                                ),
                              ),
                            },
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                    ),
                                    Text(
                                      data1[index].country,
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Cases",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                data1[index].cases.toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 25),
                                              ),
                                              Text(
                                                "TodayCases",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                data1[index]
                                                    .todayCases
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Deaths",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                data1[index].deaths.toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 25),
                                              ),
                                              Text(
                                                "TodayDeaths",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                data1[index]
                                                    .todayDeaths
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Active",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                data1[index].active.toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 25),
                                              ),
                                              Text(
                                                "Recovered",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                data1[index]
                                                    .recovered
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Critical",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                data1[index]
                                                    .critical
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 25),
                                              ),
                                              Text(
                                                "PerOneMillion",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                data1[index]
                                                    .casesPerOneMillion
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
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
      ),
    );
  }
}
