import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/9/10.
///

class BaseTouchHandlePage extends StatefulWidget {
  BaseTouchHandlePage({Key key}) : super(key: key);

  @override
  _BaseTouchHandlePageState createState() => _BaseTouchHandlePageState();
  static String get routenName => "BaseTouchHandlePage";
}

class _BaseTouchHandlePageState extends State<BaseTouchHandlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('触摸事件流程探索'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: GestureDetector(
        child: Container(
          child: Text('按压'),
          width: 100,
          height: 60,
          alignment: Alignment.center,
          color: Colors.orange,
        ),
        onTap: _onPress,
      ),
    );
  }

  void _onPress() {
    print('object');
  }
}
