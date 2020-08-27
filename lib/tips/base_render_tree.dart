import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/8/26.
///

class BaseRenderTree extends StatefulWidget {
  BaseRenderTree({Key key}) : super(key: key);

  @override
  _BaseRenderTreeState createState() => _BaseRenderTreeState();
  static String get routeName => '/BaseRenderTree';
}

class _BaseRenderTreeState extends State<BaseRenderTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3棵树'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _add,
      ),
    );
  }

  void _add() {
    setState(() {
      _count += 1;
    });
  }

  int _count = 0;
  Widget _body() {
    return Center(
      child: Column(
        children: <Widget>[
          Text.rich(
            TextSpan(
              text: '每次刷新只',
              children: [
                _widgetBold('改变Text文本,`renderobject` 不会重新创建'),
                _widget('只有当'),
                _widgetBold('`key`或者类型'),
                _widget('改变才会重新创建`renderobject`')
              ],
            ),
          ),
          Text('$_count'),
        ],
      ),
    );
  }

  TextSpan _widgetBold(String string) {
    return TextSpan(
      text: '$string',
      style: TextStyle(
          fontSize: 15, color: Colors.blueAccent, fontWeight: FontWeight.bold),
    );
  }

  TextSpan _widget(String string) {
    return TextSpan(
      text: '$string',
    );
  }
}
