import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

///
/// Created by fgyong on 2020/7/29.
///

class BaseAsynAndISOlateRoute extends StatefulWidget {
  BaseAsynAndISOlateRoute({Key key}) : super(key: key);

  @override
  _BaseAsynAndISOlateRouteState createState() =>
      _BaseAsynAndISOlateRouteState();
}

class _BaseAsynAndISOlateRouteState extends State<BaseAsynAndISOlateRoute> {
  int _fps = 0;
  String _stringFPS = '';
  @override
  void initState() {
    WidgetsBinding.instance.addTimingsCallback((timings) {
      _fps += 1;
    });
    Timer(Duration(seconds: 1), () {
      _stringFPS = _fps.toString();
      setState(() {});
      _fps = 0;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('线程'),
      ),
      body: _body(),
    );
  }

  int _count = 0;
  String _string = '';
  Widget _body() {
    return Center(
      child: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('FPS:$_stringFPS'),
              OutlineButton(
                child: Text('开辟线程'),
                onPressed: _createIso,
              ),
              OutlineButton(
                child: Text('主线程发送消息到子线程'),
                onPressed: _mainToSub,
              ),
              OutlineButton(
                child: Text('子线程发送消息到主线程'),
                onPressed: _subToMain,
              ),
              OutlineButton(
                child: Text('测试是否堵塞'),
                onPressed: () {
                  setState(() {
                    _count += 1;
                  });
                },
              ),
              Text(_count.toString()),
              OutlineButton(
                child: Text('测试是否添加耗时任务是否堵塞'),
                onPressed: () {
                  Timer.run(() {
                    setState(() {
                      _string = '耗时任务开始';
                    });
                    for (var i = 0; i < 9999999999; ++i) {
                      //
                    }
                    setState(() {
                      _string = '耗时任务结束';
                    });
                  });
                },
              ),
              Text(_string)
            ],
          ),
        ),
      ),
    );
  }

  void _createIso() {
    createTask();
  }

  void createTask() async {
    _mainReceiverPort = ReceivePort();
    isolate = await Isolate.spawn(_sendSub, _mainReceiverPort.sendPort);
    _mainReceiverPort.listen((data) {
      print('main: $data ${DateTime.now()}');
      if (data is List) {
        String msg = data[0];
        if (msg == 'close') {
          _mainReceiverPort.close();
        }
      } else if (data is SendPort) {
        _subSendPort = data;
        _subSendPort.send('主线程收到了端口from main ');
        print('main: 主线程收到了子线程的 端口');
      }
    });
    print('main:创建线程成功');
  }

  void _mainToSub() {
    print('指令发出时间：${DateTime.now()}');
    _subSendPort?.send(['主线程发出,送往子线程', 'read']);
  }

  void _subToMain() {
    _mainReceiverPort.sendPort.send(['task']);
  }
}

/// 新线程执行新的任务 并监听
Isolate isolate;
Isolate isolate2;
ReceivePort _subReceiverPort;
ReceivePort _mainReceiverPort;
SendPort _subSendPort;

void _sendSub(SendPort sendPort) async {
  _subReceiverPort = new ReceivePort();
  sendPort.send(_subReceiverPort.sendPort);
  _subReceiverPort.listen((data) async {
    print('sub:$data)');
    if (data is List) {
      String msg = data[0];
      if (data.contains('read') == true) {
        print('开始读文件时间：${DateTime.now()}');

        for (var i = 0; i < 999999999; ++i) {}
        print('读文件完成时间：${DateTime.now()}');
        sendPort.send(['子线程文件读写完成']);
      } else if (msg == 'close') {
        _subReceiverPort.close();
      } else if (msg == 'callback') {
        sendPort.send(['子线程收到了消息']);
      }
    }
  });
}
