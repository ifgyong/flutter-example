///
/// Created by fgyong on 7/20/21.
///

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseU3DPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BaseU3DPageState();
  }

  static String get routeName => '/BaseU3DPage';
}

class _BaseU3DPageState extends State<BaseU3DPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BaseU3DPage'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      child: Text('123'),
    );
  }
}
