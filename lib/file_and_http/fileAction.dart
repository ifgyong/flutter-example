import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

///
/// Created by fgyong on 2020/7/27.
///

class BaseFileRoute extends StatefulWidget {
  BaseFileRoute({Key key}) : super(key: key);

  @override
  _BaseFileRouteState createState() => _BaseFileRouteState();
}

class _BaseFileRouteState extends State<BaseFileRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('文件读取'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Text('+'),
        onPressed: () {
          setState(() {
            _count += 1;
          });
        },
      ),
    );
  }

  int _count = 0;
  String _string = '';
  String _error = '';
  String _writeStr = '';
  Widget _body() {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(_error),
              ),
              OutlineButton(
                child: Text('创建文件文件'),
                onPressed: _createFile,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              OutlineButton(
                child: Text('读取文件'),
                onPressed: _read,
              ),
              Expanded(
                child: Text(_string),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              OutlineButton(
                child: Text('写入文件'),
                onPressed: _write,
              ),
              Expanded(
                child: Text(_writeStr),
              )
            ],
          ),
          Row(
            children: <Widget>[
              OutlineButton(
                child: Text('清空文件内容'),
                onPressed: _clearData,
              ),
              Text(_count.toString()),
            ],
          )
        ],
      ),
    );
  }

  void _read() async {
    var file = new File(await _path());
    var st = await file.readAsString();
    setState(() {
      _string = st;
    });
  }

  void _write() async {
    var file = new File(await _path());
    var st = await file.readAsString();

    st += '  $_count';
    file.writeAsString(
      st,
    );
    setState(() {
      _writeStr = '写入成功 $_count';
    });
  }

  void _clearData() async {
    var file = new File(await _path());
    var st = await file.readAsString();

    st += '  $_count';
    file.writeAsString(
      '',
    );
    setState(() {
      _writeStr = '文件已清空';
    });
  }

  Future<String> _path() async {
    var path = await getTemporaryDirectory();
    var all = path.path + '/text.txt';
    return all;
  }

  void _createFile() async {
    try {
      var path = await getTemporaryDirectory();
      var all = path.path + '/text.txt';
      var current = Directory(all);
      if (current.existsSync() == false) {
        var d = new File(all);
        var f = await d.create();
        if (f.existsSync()) {
          print('创建成功 ${d.path}');
          setState(() {
            _error = '创建成功 ${d.path}';
          });
        } else {
          setState(() {
            _error = '文件创建失败';
          });
        }
      } else {
        setState(() {
          _error = '文件已存在';
        });
      }
    } catch (e) {
      setState(() {
        _error = '${e.toString()}';
      });
      print(e.toString());
    }
  }
}
