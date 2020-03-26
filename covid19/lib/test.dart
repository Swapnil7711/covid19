import 'package:flutter/material.dart';

class Country extends StatefulWidget {
  final List data;

  const Country({Key key, @required this.data}) : super(key: key);
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
    dummySearchList.addAll(data1);
    print("dummy sreach List : $dummySearchList");

    if (query.isNotEmpty) {
      for (var i = 0; i < data1.length; i++) {
        var keys = data1[i].keys.toList();

        var val = data1[i][keys[0]];

        print("val is: ${val.toLowerCase()}");

        if (val.toLowerCase().contains((query.toLowerCase()))) {
          dummyList.add(data1[i]);

          print("dummy list is : $dummyList");
        }
      }
      setState(() {
        print("if set");
        data1.clear();
        data1.addAll(dummyList);
        print("data1 : $data1");
      });

      return;
    } else {
      print("else started");
      setState(() {
        data1 = [];
        print("CLEAR DATA : $data1");
        print('original data: ${widget.data}');
        data1.addAll(data); //this is where the problem is..
        print('else data1: $data1');
        print("else ended");
      });
    }
  }

  void setData1() {
    setState(() {
      this.data1 = this.widget.data;
      print("set data : $data1");
    });
  }

  @override
  void initState() {
    super.initState();
    setData1();
    this.data = widget.data;
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
            TextField(
              controller: editingController,
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
            Expanded(
              child: ListView.builder(
                itemCount: data1.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Padding(padding: EdgeInsets.fromLTRB(8, 5, 8, 5));
                  return Card(
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
                            data1[index]['country'],
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Cases",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    Text(
                                      data1[index]["cases"].toString(),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 25),
                                    ),
                                    Text(
                                      "TodayCases",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    Text(
                                      data1[index]["todayCases"].toString(),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Deaths",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    Text(
                                      data1[index]["deaths"].toString(),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 25),
                                    ),
                                    Text(
                                      "TodayDeaths",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    Text(
                                      data1[index]["todayDeaths"].toString(),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Active",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    Text(
                                      data1[index]["active"].toString(),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 25),
                                    ),
                                    Text(
                                      "Recovered",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    Text(
                                      data1[index]["recovered"].toString(),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Critical",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    Text(
                                      data1[index]["critical"].toString(),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 25),
                                    ),
                                    Text(
                                      "PerOneMillion",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    Text(
                                      data1[index]["casesPerOneMillion"]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
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
