import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(FinanceTracker());
}

class FinanceTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
