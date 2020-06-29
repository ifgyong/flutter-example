import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseIndicator extends StatefulWidget {
  _BaseIndicatorState createState() => _BaseIndicatorState();
}

class _BaseIndicatorState extends State<BaseIndicator>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('进度指示器'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.orange),
          backgroundColor: Colors.black12,
        ),
        SizedBox(
          height: 20,
        ),
        LinearProgressIndicator(
//          value: 0.1,
          valueColor: AlwaysStoppedAnimation(Colors.orange),
          backgroundColor: Colors.black12,
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 20,
          width: 200,
          child: LinearProgressIndicator(
//          value: 0.1,
            valueColor: AlwaysStoppedAnimation(Colors.orange),
            backgroundColor: Colors.black12,
          ),
        ),
        SizedBox(
          height: 50,
        ),
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.orange),
          backgroundColor: Colors.greenAccent,
        ),
        SizedBox(
          height: 50,
        ),
        SizedBox(
          height: 200,
          width: 200,
          child: CircularProgressIndicator(
            valueColor: ColorTween(begin: Colors.grey, end: Colors.orange)
                .animate(_controller),
            backgroundColor: Colors.black12,
            strokeWidth: 10,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 200,
          width: 200,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: CircularProgressIndicator(
                  valueColor: ColorTween(begin: Colors.blue, end: Colors.orange)
                      .animate(_controller),
                  backgroundColor: Colors.black12,
                  strokeWidth: 10,
                  value: _value,
                ),
              ),
              Positioned.fill(
                  child: Center(
                child: Text(
                  '${(_value * 100).toDouble().toStringAsFixed(2)}%',
                  style: TextStyle(fontSize: 20, color: Colors.orange),
                ),
              ))
            ],
          ),
        ),
      ],
    );
  }

  AnimationController _controller;
  Timer _timer;
  double _value = 0;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 2000))
          ..repeat();
    _timer = Timer.periodic(Duration(milliseconds: 16), (t) {
      _value += 0.01;
      if (_value >= 1.0) {
        _value = 0;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}
