import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/9/2.
///

class BaseImagePage extends StatefulWidget {
  BaseImagePage({Key key}) : super(key: key);

  @override
  _BaseImagePageState createState() => _BaseImagePageState();
  static String get routeName => '/BaseImagePage';
}

class _BaseImagePageState extends State<BaseImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片加载'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    Image widget = Image.asset('img/2.png');
    print('${widget.width} ${widget.height}');
    print('${widget.toString()}');
    return Center(
      child: Image.assfet('img/2.png'),
    );
  }
}
