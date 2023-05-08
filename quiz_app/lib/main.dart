import 'package:flutter/material.dart';
import 'package:quiz_app/questions.dart';
import './questions.dart';
import './answer.dart';
import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _quesind = 0;
  var _totalscore = 0;

  void _reset() {
    setState(() {
      _quesind = 0;
      _totalscore = 0;
    });
  }

  void _answer(int score) {
    _totalscore += score;
    setState(() {
      _quesind += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    const que = [
      {
        'quest': 'What\'s Your Name ?',
        'ans': [
          {'text': 'Ayush', 'score': 10},
          {'text': 'Augutsya', 'score': 8},
          {'text': 'Anurag', 'score': 7},
          {'text': 'Ansh', 'score': 5}
        ],
      },
      {
        'quest': 'What\'s Your Favourite Game ?',
        'ans': [
          {'text': 'Cricket', 'score': 10},
          {'text': 'Hockey', 'score': 8},
          {'text': 'Table Tennis', 'score': 6},
          {'text': 'Football', 'score': 3}
        ],
      },
    ];

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Quiz App'),
          ),
          body: _quesind < que.length
              ? Quiz(_answer, que, _quesind)
              : Result(_totalscore, _reset),
        ));
  }
}
