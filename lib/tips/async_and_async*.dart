import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

///
/// Created by fgyong on 2020/7/29.
///

class BaseAsync extends StatefulWidget {
  BaseAsync({Key key}) : super(key: key);

  @override
  _BaseAsyncState createState() => _BaseAsyncState();
}

class _BaseAsyncState extends State<BaseAsync> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('异步与同步数据流'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text('${stringBuffer.toString()}'),
          )
        ],
      ),
    );
  }

  int _count = 0;

  /// 异步数据流
  Stream<int> _stream() async* {
    if (_count < 10) {
      yield _count++;

      await Future.delayed(Duration(seconds: 1));
      sleep(Duration(seconds: 1));
      yield* _stream();
    }
  }

  StringBuffer stringBuffer;

  /// 同步获取数据
  Iterable<int> _streamIterable() sync* {
    if (_count < 20) {
      yield _count;
      yield* _streamIterable();
    }
  }

  @override
  void initState() {
    stringBuffer = StringBuffer();
    _stream().listen((event) {
      stringBuffer.write(event);
//      stringBuffer.writeln(event)
      setState(() {});
      print(event);
    });
    super.initState();
  }
}
