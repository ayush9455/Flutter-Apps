import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/orders.dart';
import 'package:shop_app/Widgets/orderTile.dart';

class ordersScreen extends StatefulWidget {
  static const routeName = "/order-details";

  const ordersScreen({super.key});

  @override
  State<ordersScreen> createState() => _ordersScreenState();
}

class _ordersScreenState extends State<ordersScreen> {
  var isInit = true;
  var isLoading = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Orders>(context).FetchAndLoad().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (ctx, ind) => orderTile(orders.item[ind]),
              itemCount: orders.itemCount,
            ),
    );
  }
}
