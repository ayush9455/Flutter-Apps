import '../models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction extends StatelessWidget {
  final List<transactions> user_txn;
  final Function delete_txn;
  Transaction(this.user_txn, this.delete_txn);

  @override
  Widget build(BuildContext context) {
    return user_txn.isEmpty
        ? Column(
            children: [
              Text(
                'NO TRANSACTIONS EXISTS !',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top) *
                    0.5,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : ListView.builder(
            itemCount: user_txn.length,
            itemBuilder: (context, indx) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text(
                              '₹' + user_txn[indx].amount.toStringAsFixed(2))),
                    ),
                  ),
                  title: Text(
                    user_txn[indx].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(user_txn[indx].date)),
                  trailing: MediaQuery.of(context).size.width > 450
                      ? TextButton.icon(
                          onPressed: () => delete_txn(user_txn[indx].id),
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          label: Text('Delete'))
                      : IconButton(
                          onPressed: () => delete_txn(user_txn[indx].id),
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).colorScheme.error,
                          )),
                ),
              );
            },
          );
  }
}
