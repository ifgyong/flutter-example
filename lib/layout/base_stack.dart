import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BaseStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('相对位置'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              child: _body(),
              constraints: BoxConstraints.loose(Size(100, 100)),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: _body2(),
              color: Colors.black12,
              constraints: BoxConstraints.expand(width: 200, height: 200),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: _body3(),
              color: Colors.black12,
              constraints: BoxConstraints.expand(width: 200, height: 200),
            )
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.bottomRight,
      children: <Widget>[
        Positioned.fill(
            child: Container(
          color: Colors.red,
        )),
        Positioned.fill(
            left: 20,
            right: 20,
            bottom: 20,
            top: 20,
            child: Container(
              color: Colors.deepOrangeAccent,
            )),
        Positioned.fill(
            left: 40,
            right: 40,
            bottom: 40,
            top: 40,
            child: Container(
              color: Colors.orange,
            )),
      ],
    );
  }

  Widget _body2() {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          child: Text("Hello world", style: TextStyle(color: Colors.white)),
          color: Colors.red,
        ),
        Positioned(
          top: 20.0,
          child: Container(
            child: Text("Are you OK?"),
            color: Colors.blue,
          ),
        ),
        Positioned(
            left: 18.0,
            child: Container(
              child: Text("I am Jack"),
              color: Colors.blue,
            )),
      ],
    );
  }

  Widget _body3() {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.bottomRight,
      children: <Widget>[
        Positioned(
          left: 0,
          right: 0,
          height: 50,
          child: Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text('Are you OK?'),
          ),
        ),
        Positioned(
          right: 0,
          height: 50,
          width: 50,
          top: 0,
          child: Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text('I ma Jack!'),
          ),
        ),
        Positioned(
          height: 40,
          width: 60,
          child: Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text('hello'),
          ),
        ),
      ],
    );
  }
}
