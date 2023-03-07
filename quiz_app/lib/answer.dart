import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String ans;

  Answer(this.selectHandler, this.ans);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: selectHandler,
        child: Text(ans),
        style:
            ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.teal)),
      ),
    );
  }
}
