import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseRowAndColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('线性布局'),
        ),
        body: SafeArea(
          child: _bd3(),
        ));
  }

  Widget _bd2() {
    return Column(
      children: <Widget>[
        _column(MainAxisAlignment.start, CrossAxisAlignment.start),
        _column(MainAxisAlignment.center, CrossAxisAlignment.start),
        _column(MainAxisAlignment.end, CrossAxisAlignment.start),
        _column(MainAxisAlignment.spaceAround, CrossAxisAlignment.start),
        _column(MainAxisAlignment.spaceEvenly, CrossAxisAlignment.start),
        _column(MainAxisAlignment.spaceBetween, CrossAxisAlignment.start),
        _column(MainAxisAlignment.start, CrossAxisAlignment.start),
        _column(MainAxisAlignment.start, CrossAxisAlignment.center),
        _column(MainAxisAlignment.start, CrossAxisAlignment.end),
        _column(MainAxisAlignment.start, CrossAxisAlignment.stretch),
//        _column(MainAxisAlignment.start, CrossAxisAlignment.start),
      ],
    );
  }

  Widget _column(MainAxisAlignment mainAxisAlignment,
      CrossAxisAlignment crossAxisAlignment) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      color: Colors.black12,
      height: 105,
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: <Widget>[
          Text('$mainAxisAlignment $crossAxisAlignment'),
          Container(
            color: Colors.blue,
            child: Text('Hello,'),
          ),
          Container(
            color: Colors.red,
            child: Text('I am'),
          ),
          Container(
            color: Colors.orange,
            child: Text('Jack ma'),
          ),
        ],
      ),
    );
  }

  Widget _bd() {
    return Column(
      children: <Widget>[
        _body(MainAxisAlignment.start, CrossAxisAlignment.start),
        _body(MainAxisAlignment.end, CrossAxisAlignment.start),
        _body(MainAxisAlignment.spaceBetween, CrossAxisAlignment.start),
        _body(MainAxisAlignment.spaceEvenly, CrossAxisAlignment.start),
        _body(MainAxisAlignment.spaceAround, CrossAxisAlignment.start),
        _body(MainAxisAlignment.center, CrossAxisAlignment.start),
        _body(MainAxisAlignment.center, CrossAxisAlignment.start),
        _body(MainAxisAlignment.center, CrossAxisAlignment.stretch),
        _body(MainAxisAlignment.center, CrossAxisAlignment.end),
      ],
    );
  }

  Widget _body(MainAxisAlignment mainAxisAlignment,
      CrossAxisAlignment crossAxisAlignment) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          Text('$mainAxisAlignment $crossAxisAlignment'),
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: <Widget>[
                Container(
                  color: Colors.blue,
                  child: Text('Hello,'),
                ),
                Container(
                  color: Colors.red,
                  child: Text('I am'),
                ),
                Container(
                  color: Colors.orange,
                  child: Text('Jack ma'),
                ),
              ],
            ),
            color: Colors.black12,
          )
        ],
      ),
    );
  }

  Widget _bd3() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20),
              color: Colors.red,
              child: Text('Are you OK?'),
            ),
          ),
        ],
      ),
    );
  }
}
