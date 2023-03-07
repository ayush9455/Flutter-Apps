import 'package:flutter/material.dart';
import '../widgets/new_txn.dart';
import '../models/transactions.dart';
import '../widgets/transactions_list.dart';

class user_txn extends StatefulWidget {
  user_txn({super.key});
  @override
  State<user_txn> createState() => _user_txnState();
}

class _user_txnState extends State<user_txn> {
  final List<transactions> _user_transactions = [];
  void _addtxn(String txntitle, double txnamt) {
    final txn = transactions(
        id: DateTime.now().toString(),
        title: txntitle,
        amount: txnamt,
        date: DateTime.now());
    setState(() {
      _user_transactions.add(txn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        new_txn(_addtxn),
        Transaction(_user_transactions),
      ],
    );
  }
}
