import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/orders.dart' as ord;

class orderTile extends StatefulWidget {
  // final String id;
  // orderTile(this.id);
  final ord.orderItem order;
  orderTile(this.order);

  @override
  State<orderTile> createState() => _orderTileState();
}

class _orderTileState extends State<orderTile> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    // final order = Provider.of<Orders>(context).item;
    // final loadorder = order.firstWhere((element) => element.id == id);

    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              "₹${widget.order.amount.toStringAsFixed(2)}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle:
                Text(DateFormat('dd MM yyyy hh:mm').format(widget.order.date)),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more)),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.all(15),
              height: min(widget.order.products.length * 20.0 + 40, 100),
              child: ListView(
                children: widget.order.products
                    .map((prod) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              prod.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                "${prod.quantity} X ${prod.price.toStringAsFixed(2)}"),
                          ],
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
