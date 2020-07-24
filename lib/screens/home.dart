import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/widgits/chart.dart';
import './../models/transaction.dart';
import './../widgits/transaction-cards.dart';
import './../widgits/create-transaction-card.dart';

const buttonText = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> _transactions = [
    // Transaction(
    //   id: "t1",
    //   title: "New Shoes",
    //   amount: 10.00,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t2",
    //   title: "Weekly Groceries",
    //   amount: 78.03,
    //   date: DateTime.now(),
    // ),
  ];

  var _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions
        .where(
          (trans) => trans.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void _addTransaction({String title, double amount, DateTime date}) {
    setState(() {
      _transactions.add(Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date,
      ));
    });
  }

  Future<void> _removeTransaction(Transaction transToDelete) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Are you sure you want to remove ${transToDelete.title}(\$${transToDelete.amount.toStringAsFixed(2)}) from transactions.'),
          content: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Keep',
                    style: buttonText,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                RaisedButton(
                  color: Theme.of(context).errorColor,
                  child: Text(
                    'Remove',
                    style: buttonText,
                  ),
                  onPressed: () {
                    setState(() {
                      _transactions = _transactions
                          .where((trans) => trans.id != transToDelete.id)
                          .toList();
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: AddTransactionCard(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        "Finance Tracker",
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );

    var _appHeight = MediaQuery.of(context).size.height -
        (appBar.preferredSize.height + MediaQuery.of(context).padding.top);

    var lowHeight = MediaQuery.of(context).size.height <= 500;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (lowHeight)
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Toggle Chart"),
                    Switch(
                      value: _showChart,
                      onChanged: (val) => setState(() => _showChart = val),
                    ),
                  ],
                ),
              ),
            if (!lowHeight)
              Container(
                height: _appHeight * 0.35,
                child: Chart(_recentTransactions),
              ),
            if (lowHeight && _showChart == true)
              Container(
                height: _appHeight - 125,
                child: Chart(_recentTransactions),
              ),
            if (!lowHeight || _showChart == false)
              Container(
                height: lowHeight ? _appHeight - 50 : _appHeight * 0.65,
                child: TransactionCards(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
