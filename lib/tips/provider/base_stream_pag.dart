import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///
/// Created by fgyong on 2020/8/20.
///

class BaseProviderStreamRoute extends StatelessWidget {
  BaseProviderStreamRoute({Key key}) : super(key: key);

  static MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (_) => _BaseProviderStreamRoute2());
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _ModelStream(),
      lazy: false,
      builder: (context, child) {
        return _BaseProviderStreamRoute2();
      },
    );
  }
}

class _BaseProviderStreamRoute2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _ModelStream stream = context.read<_ModelStream>();
    return StreamProvider<int>.value(
      value: stream.firstStream,
      lazy: false,
      initialData: 0,
      child: _BaseProviderStreamRoute(),
    );
  }
}

class _BaseProviderStreamRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return __BaseProviderStream();
  }
}

class __BaseProviderStream extends State<_BaseProviderStreamRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('定时器'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('${context.select<int, String>((value) => value.toString())}'),
            OutlineButton(
              child: Text('stop'),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

class _ModelStream extends ChangeNotifier {
  StreamController<int> _streamController;
  Timer _timer;
  int count = 0;
  _ModelStream() {
    _streamController = StreamController();
    initTimer();
  }
  void initTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _streamController.add(count++);
    });
  }

  Stream<int> get firstStream => _streamController.stream;
  void add() {
    _streamController.add(1);
  }

  void reset() {
    count = 0;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}

class _ValueModel {
  final int value;
  const _ValueModel({this.value});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ValueModel &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  _ValueModel.name(this.value);
}
