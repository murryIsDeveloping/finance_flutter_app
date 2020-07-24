import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactionCard extends StatefulWidget {
  final Function({String title, double amount, DateTime date}) addTransaction;

  AddTransactionCard(this.addTransaction);

  @override
  _AddTransactionCardState createState() => _AddTransactionCardState();
}

class _AddTransactionCardState extends State<AddTransactionCard> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _presentDataPicker() async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime.now());

    setState(() {
      _selectedDate = date;
    });
  }

  void _submitData() {
    var amount = double.parse(_amountController.text);
    var title = _titleController.text;

    if (amount <= 0 || title.isEmpty) {
      return;
    }

    widget.addTransaction(
        title: title, amount: amount, date: _selectedDate ?? DateTime.now());
    _titleController.clear();
    _amountController.clear();
    _selectedDate = null;

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
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Title",
              ),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: "Amount",
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                      _selectedDate == null
                          ? "No Date Chosen"
                          : DateFormat("MMM d, y").format(_selectedDate),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ),
                FlatButton(
                  child: Text(
                    _selectedDate == null ? "Choose Date" : "Change Date",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: _presentDataPicker,
                ),
              ],
            ),
            FlatButton(
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: _submitData,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
