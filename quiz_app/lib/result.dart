import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Result extends StatelessWidget {
  final int res;
  final VoidCallback resethandler;
  Result(this.res, this.resethandler);

  String get result_phrase {
    String restext = "Your Are Best";
    if (res < 8)
      restext = 'You Are Bad';
    else if (res < 12)
      restext = 'You Are Strange';
    else if (res < 30) restext = "Your Are Good";
    return restext;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            result_phrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: resethandler,
            child: Text("Restart"),
          )
        ],
      ),
    );
  }
}
