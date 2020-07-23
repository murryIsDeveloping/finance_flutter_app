import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_tracker/widgits/chart-bar.dart';
import './../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;
      for (var trans in recentTransactions) {
        if (DateFormat.yMMMd().format(trans.date) ==
            DateFormat.yMMMd().format(weekDay)) {
          totalSum += trans.amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay),
        "amount": totalSum,
      };
    });
  }

  double get maxSpending {
    return groupedTransactionValues.fold(
        0.0, (previousValue, element) => previousValue + element["amount"]);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionValues
            .map((t) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      label: t["day"],
                      spendingAmount: t["amount"],
                      spendingPtOfTotal: maxSpending == 0.0
                          ? 0.0
                          : (t["amount"] as double) / maxSpending),
                ))
            .toList(),
      ),
    );
  }
}
