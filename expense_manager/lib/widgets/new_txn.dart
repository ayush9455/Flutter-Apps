import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class new_txn extends StatefulWidget {
  final Function add_txn;

  new_txn(this.add_txn);

  @override
  State<new_txn> createState() => _new_txnState();
}

class _new_txnState extends State<new_txn> {
  DateTime _selecteddate = DateTime.now();

  final _titlecontroller = TextEditingController();

  final _amountcontroller = TextEditingController();

  void submitData() {
    String enteredTitle = _titlecontroller.text;
    double enteredamt = double.parse(_amountcontroller.text);
    if (enteredTitle.isEmpty || enteredamt <= 0) return;
    widget.add_txn(enteredTitle, enteredamt, _selecteddate);
    Navigator.of(context).pop();
  }

  void _presentdatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickeddate) {
      if (pickeddate == null)
        return;
      else {
        setState(() {
          _selecteddate = pickeddate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        color: Colors.teal[300],
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              10, 10, 10, MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titlecontroller,
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
              ),
              TextField(
                controller: _amountcontroller,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          'Picked Date : ${DateFormat.yMMMd().format(_selecteddate)}'),
                    ),
                    TextButton(
                      onPressed: _presentdatepicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                            color: Color.fromARGB(255, 2, 31, 24),
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4),
                child: ElevatedButton(
                  onPressed: submitData,
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(
                      color: Color.fromARGB(255, 4, 34, 56),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
