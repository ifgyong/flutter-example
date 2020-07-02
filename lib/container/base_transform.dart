import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseTransform extends StatefulWidget {
  _BaseTransformState createState() => _BaseTransformState();
}

class _BaseTransformState extends State<BaseTransform> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('变换 Transform'),
      ),
      body: _body(),
    );
  }

  double _rotate = 0, _scale = 1.0, _rotateX = 0, _rotateY = 0;
  Offset _offset = Offset(0, 0);

  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Transform.rotate(
            angle: _rotate,
            alignment: Alignment.center,
            child: Container(
              child: Text('Transform.rotate'),
              color: Colors.blue,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('旋转角度：' + _rotate.toStringAsFixed(2)),
              CupertinoSlider(
                value: _rotate,
                max: pi * 2,
                min: 0,
                onChanged: (v) {
                  setState(() {
                    _rotate = v;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Transform.scale(
            scale: _scale,
            alignment: Alignment.center,
            child: Container(
              child: Text('Transform.scale'),
              color: Colors.blueAccent,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('放大倍数：' + _scale.toStringAsFixed(2)),
              CupertinoSlider(
                value: _scale,
                max: 3,
                min: 0.01,
                onChanged: (v) {
                  setState(() {
                    _scale = v;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Transform.translate(
            offset: _offset,
            child: Container(
              child: Text('Transform.translate'),
              color: Colors.blueAccent,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('位移X：' + _offset.dx.toStringAsFixed(2)),
              CupertinoSlider(
                value: _offset.dx,
                max: 100,
                min: -100,
                onChanged: (v) {
                  setState(() {
                    _offset = Offset(v, _offset.dy);
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('位移Y：' + _offset.dy.toStringAsFixed(2)),
              CupertinoSlider(
                value: _offset.dy,
                max: 100,
                min: -100,
                onChanged: (v) {
                  setState(() {
                    _offset = Offset(_offset.dx, v);
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Transform(
            transform: new Matrix4.identity()
              ..setEntry(3, 2, 0.01)
              ..rotateX(_rotateX)
              ..rotateY(_rotateY),
            alignment: Alignment.center,
            child: Container(
              width: 100,
              height: 100,
              child: Text('Matrix4'),
              alignment: Alignment.center,
              color: Colors.lightBlueAccent,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('翻转X：' + _rotateX.toStringAsFixed(2)),
              CupertinoSlider(
                value: _rotateX,
                max: pi / 2,
                min: -pi / 2,
                onChanged: (v) {
                  setState(() {
                    _rotateX = v;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('翻转Y：' + _rotateY.toStringAsFixed(2)),
              CupertinoSlider(
                value: _rotateY,
                max: pi / 2,
                min: -pi / 2,
                onChanged: (v) {
                  setState(() {
                    _rotateY = v;
                  });
                },
              ),
            ],
          ),
          Container(
            color: Colors.orange,
            width: 120,
            height: 50,
            alignment: Alignment.center,
            child: RotatedBox(
              child: Container(
                width: 100,
                height: 100,
                child: Text('RotatedBox'),
                color: Colors.lightBlueAccent,
              ),
              quarterTurns: 1,
            ),
          )
        ],
      ),
    );
  }
}
