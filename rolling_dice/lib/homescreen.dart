import 'dart:math';

import 'package:flutter/material.dart';
import 'main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int lDiceno = 1;
  int rDiceno = 1;
  late AnimationController _controller;
  late CurvedAnimation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  animate() {
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    animation.addListener(() {
      setState(() {});
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          lDiceno = Random().nextInt(6) + 1;
          rDiceno = Random().nextInt(6) + 1;
        });
        print('Completed');
        _controller.reverse();
      }
    });
  }

  void Roll() {
    setState(() {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Dicee')),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 250,
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onDoubleTap: Roll,
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Image(
                            height: 200 - (animation.value) * 200,
                            image:
                                AssetImage('assets/images/dice$lDiceno.png'))),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onDoubleTap: Roll,
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Image(
                            height: 200 - (animation.value) * 200,
                            image:
                                AssetImage('assets/images/dice$rDiceno.png'))),
                  )),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: Roll,
              child: Text(
                'Roll',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ]),
        ));
  }
}
