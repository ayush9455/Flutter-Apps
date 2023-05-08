import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import './questions.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> que;
  final int quesind;
  final Function answer;

  Quiz(this.answer, this.que, this.quesind);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Questions(que[quesind]['quest'] as String),
        ...(que[quesind]['ans'] as List<Map<String, Object>>).map((answ) {
          return Answer(() => answer(answ['score']), answ['text'] as String);
        }).toList()
      ],
    );
  }
}
