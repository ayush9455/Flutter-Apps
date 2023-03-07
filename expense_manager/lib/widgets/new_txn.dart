import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class new_txn extends StatelessWidget {
  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  final Function add_txn;

  new_txn(this.add_txn);

  void submitData() {
    String enteredTitle = titlecontroller.text;
    double enteredamt = double.parse(amountcontroller.text);
    if (enteredTitle.isEmpty || enteredamt <= 0) return;
    add_txn(enteredTitle, enteredamt);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 101, 196, 227),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titlecontroller,
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              controller: amountcontroller,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              margin: EdgeInsets.only(top: 4),
              child: TextButton(
                  onPressed: submitData,
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(
                      color: Color.fromARGB(255, 19, 65, 100),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
