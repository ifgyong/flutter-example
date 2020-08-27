import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

///
/// Created by fgyong on 2020/8/24.
///

class BaseDartPage extends StatefulWidget {
  BaseDartPage({Key key}) : super(key: key);

  @override
  _BaseDartPageState createState() => _BaseDartPageState();
  static String get routeName => '/BaseDartPage';
}

class _BaseDartPageState extends State<BaseDartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        children: <Widget>[
          TextField(
            onChanged: (v) {
              _streamController.add(v);
            },
          )
        ],
      ),
    );
  }

  StreamController<String> _streamController;
  PublishSubject _subject;
  StreamSubscription<String> _subscription;
  @override
  void initState() {
    _streamController = StreamController();
//    _subscription  =StreamSubscription()
    _streamController.stream.listen((event) {});
    _streamController.add('data');
    //    _subject = PublishSubject();
//    _subject.stream..where((event) => event.length < 5);
//
//    _subject.add('str');

//    Rx.repeat<int>((repeatIndex) => Stream.value(repeatIndex)).listen((event) {
//      print(event);
//    });
//    Rx.timer<int>(0, Duration(seconds: 1)).listen((event) {
//      print(event);
//    });
    print(Zone.root.toString());
    super.initState();
  }
}
