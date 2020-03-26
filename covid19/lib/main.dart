import 'package:covid19/Home.dart';
import 'package:flutter/material.dart';

void main() => runApp(Covid19());

class Covid19 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Covid 19 Data",
      home: Home(),
    );
  }
}
