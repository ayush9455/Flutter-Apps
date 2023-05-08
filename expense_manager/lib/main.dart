import 'package:expense_manager/widgets/chart.dart';

import './widgets/transactions_list.dart';
import './widgets/new_txn.dart';
import 'package:flutter/material.dart';
import './models/transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Manager',
      theme: ThemeData(primarySwatch: Colors.teal, useMaterial3: false),
      debugShowCheckedModeBanner: false,
      home: Myhomepage(),
    );
  }
}

class Myhomepage extends StatefulWidget {
  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  final List<transactions> _user_transactions = [];
  Size get preferredSize => Size.zero;
  void _addtxn(String txntitle, double txnamt, DateTime txndate) {
    final txn = transactions(
        id: DateTime.now().toString(),
        title: txntitle,
        amount: txnamt,
        date: txndate);
    setState(() {
      _user_transactions.add(txn);
    });
  }

  List<transactions> get recent_txn {
    return _user_transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _startaddtxn(BuildContext ctx) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.teal[300],
        elevation: 5,
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: new_txn(_addtxn),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  bool showch = false;

  void _deletetxn(String id) {
    setState(() {
      _user_transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final islandascape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final txn_list = Container(
        height: (MediaQuery.of(context).size.height -
                AppBar.preferredHeightFor(context, preferredSize) -
                MediaQuery.of(context).padding.top) *
            0.75,
        child: Transaction(_user_transactions, _deletetxn));

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 233, 233),
      appBar: AppBar(
        title: Text('Expense Manager'),
        actions: [
          IconButton(
              onPressed: () => _startaddtxn(context), icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (islandascape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Chart',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Switch(
                      value: showch,
                      onChanged: (bool val) {
                        setState(() {
                          showch = val;
                        });
                      }),
                ],
              ),
            if (!islandascape)
              Container(
                  height: (MediaQuery.of(context).size.height -
                          AppBar.preferredHeightFor(context, preferredSize) -
                          MediaQuery.of(context).padding.top) *
                      0.2,
                  child: Chart(recent_txn)),
            if (!islandascape) txn_list,
            if (islandascape)
              showch
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              AppBar.preferredHeightFor(
                                  context, preferredSize) -
                              MediaQuery.of(context).padding.top -
                              kToolbarHeight) *
                          0.5,
                      child: Chart(recent_txn))
                  : txn_list
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startaddtxn(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
