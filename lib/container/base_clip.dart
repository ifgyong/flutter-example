import 'dart:math';

import 'package:flutter/material.dart';

class BaseClip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('裁剪部件'),
      ),
      body: Center(
        child: _body2(),
      ),
    );
  }

  Widget _body() {
    Widget avator = Container(
      width: 100,
      height: 100,
      color: Colors.blue,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('ClipOval 剪切圆形'),
        ClipOval(
          child: avator,
        ),
        Text('ClipOval 圆角'),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: avator,
        ),
        Text('ClipOval 剪切为原来的1/4'),
        ClipRect(
          child: Align(
            alignment: Alignment.topRight,
            widthFactor: 0.5,
            heightFactor: 0.5,
            child: avator,
          ),
        )
      ],
    );
  }

  Widget _body2() {
    Widget avator = Container(height: 200,width: 200,child: Image.asset('img/1.jpeg',),);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipPath(
          child: avator,
          clipper: BaseCustomPath(),
        )
      ],
    );
  }
}

class BaseCustomPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width / 2, 40);
    path.lineTo(size.width - 15, size.height - 15);
    path.lineTo(15, size.height - 15);

    double p1 = 1 * pi;
    path.addArc(Rect.fromLTWH(30,30,30,30),
        p1, p1 + 2 * pi);
    path.lineTo(15, size.height - 15);
    path.addArc(
        Rect.fromLTWH(size.width - 30,30,30,30),
        p1,
        p1 + 2 * pi);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return this != oldClipper;
  }
}
