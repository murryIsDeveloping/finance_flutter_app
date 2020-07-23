import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/models/transaction.dart';
import 'package:personal_finance_tracker/widgits/create-transaction-card.dart';
import 'package:personal_finance_tracker/widgits/transaction-cards.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  List<Transaction> _transactions = [
    Transaction(
      id: "t1",
      title: "New Shoes",
      amount: 10.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Weekly Groceries",
      amount: 78.03,
      date: DateTime.now(),
    ),
  ];

  void addTransaction({String title, double amount}) {
    setState(() {
      _transactions.add(Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text("Chart"),
              elevation: 5.0,
            ),
          ),
          AddTransactionCard(addTransaction),
          TransactionCards(_transactions),
        ],
      ),
    );
  }
}
