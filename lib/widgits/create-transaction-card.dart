import 'package:flutter/material.dart';

class AddTransactionCard extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function({String title, double amount}) addTransaction;

  AddTransactionCard(this.addTransaction);

  void submitData() {
    var amount = double.parse(amountController.text);
    var title = titleController.text;

    if (amount <= 0 || title.isEmpty) {
      addTransaction(title: title, amount: amount);
      titleController.clear();
      amountController.clear();
    }
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
              color: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
