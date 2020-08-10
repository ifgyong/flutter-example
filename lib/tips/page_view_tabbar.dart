import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/8/7.
///

class FYTabbarWidget extends StatefulWidget {
  FYTabbarWidget({Key key}) : super(key: key);

  @override
  _FYTabbarWidgetState createState() => _FYTabbarWidgetState();
}

class _FYTabbarWidgetState extends State<FYTabbarWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tabbar'),
      ),
      body: _body(),
    );
  }

  bool _isStop = false;

  Widget _body() {
    return Center(
      child: Column(
        children: <Widget>[
          FlatButton(
            child: Text(
              'push stop',
            ),
            onPressed: () {
              setState(() {
                _isStop = !_isStop;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
