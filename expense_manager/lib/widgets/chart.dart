import './chart_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '/models/transactions.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Chart extends StatelessWidget {
  List<transactions> recent_txn;
  Chart(this.recent_txn);

  List<Map<String, Object>> get groupedtxn {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var total_amt = 0.0;
      for (var i = 0; i < recent_txn.length; i++) {
        if (recent_txn[i].date.day == weekday.day &&
            recent_txn[i].date.month == weekday.month &&
            recent_txn[i].date.year == weekday.year) {
          total_amt += recent_txn[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekday), 'amt': total_amt};
    }).reversed.toList();
  }

  double get totspending {
    return groupedtxn.fold(0.0, (sum, item) {
      return sum + (item['amt'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.teal[800],
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: groupedtxn.map((data) {
              return Chart_Bar(
                  data['day'].toString(),
                  data['amt'] as double,
                  totspending == 0.0
                      ? 0.0
                      : (data['amt'] as double) / totspending);
            }).toList()),
      ),
      elevation: 6,
    );
  }
}
