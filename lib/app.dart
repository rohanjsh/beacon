import 'package:flutter/material.dart';
import 'package:qualification_1/pages/hyperHome.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HyperTrackQuickStart(),
    );
  }
}
