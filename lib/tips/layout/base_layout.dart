import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/8/21.
///

class BaseLayoutPage extends StatefulWidget {
  BaseLayoutPage({Key key}) : super(key: key);

  @override
  _BaseLayoutPageState createState() => _BaseLayoutPageState();
  static String get routeName => '/_BaseLayoutPageState';
}

class _BaseLayoutPageState extends State<BaseLayoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: <Widget>[
        Container(
//          width: 100,
//          height: 100,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              print('$constraints');
              return Text('constraints');
            },
          ),
        )
      ],
    );
  }
}
