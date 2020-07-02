import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseContainer extends StatefulWidget {
  @override
  _BaseContainerState createState() => _BaseContainerState();
}

class _BaseContainerState extends State<BaseContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container容器'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            clipBehavior: Clip.none,
            width: 200,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient:
                    LinearGradient(colors: [Colors.orange, Colors.deepOrange])),
            transform: Matrix4.identity()..rotateZ(pi / 10),
            child: Text(
              'www.flutter.fgyong.cn',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            alignment: Alignment.center,
          )
        ],
      ),
    );
  }
}
