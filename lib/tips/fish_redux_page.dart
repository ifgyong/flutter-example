import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/8/17.
///

class BaseFishReduxPage extends StatefulWidget {
  BaseFishReduxPage({Key key}) : super(key: key);

  @override
  _BaseFishReduxPageState createState() => _BaseFishReduxPageState();
  static String routeName = "/BaseFishReduxPage";
}

class _BaseFishReduxPageState extends State<BaseFishReduxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fish'),
      ),
      body: _body(),
    );
  }

  Widget _body() {}
}
