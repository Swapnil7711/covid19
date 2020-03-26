import 'package:flutter/material.dart';

class Map extends StatefulWidget {
  final data;

  const Map({Key key, this.data}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Country Map"),
        ),
        body: Center(
          child: Container(
            child: RaisedButton(
              onPressed: () {},
              // child: ListView.builder(
              //     itemCount: dates.length,
              //     itemBuilder: (context, index) {
              //       return ListTile(
              //         title: dates[index],
              //         subtitle: cases[index],
              //       );
              // },),
            ),
          ),
        ));
  }
}
