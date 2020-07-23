import 'package:flutter/material.dart';
import './../widgits/user-transactions.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOW MUCH HAVE YOU SPENT"),
      ),
      body: UserTransactions(),
    );
  }
}
