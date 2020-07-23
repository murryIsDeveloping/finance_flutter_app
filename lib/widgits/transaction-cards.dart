import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionCards extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionCards(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) => Card(
          elevation: 5.0,
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2),
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  "\$" + transactions[index].amount.toStringAsFixed(2),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transactions[index].title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat("d-M-y, hh:mm aa")
                        .format(transactions[index].date),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
