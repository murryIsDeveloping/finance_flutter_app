import 'package:flutter/material.dart';

class AddTransactionCard extends StatefulWidget {
  final Function({String title, double amount}) addTransaction;

  AddTransactionCard(this.addTransaction);

  @override
  _AddTransactionCardState createState() => _AddTransactionCardState();
}

class _AddTransactionCardState extends State<AddTransactionCard> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    var amount = double.parse(amountController.text);
    var title = titleController.text;

    if (amount <= 0 || title.isEmpty) {
      return;
    }

    widget.addTransaction(title: title, amount: amount);
    titleController.clear();
    amountController.clear();

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: titleController,
              onSubmitted: (_) => submitData(),
              decoration: InputDecoration(
                labelText: "Title",
              ),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: "Amount",
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: submitData,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
