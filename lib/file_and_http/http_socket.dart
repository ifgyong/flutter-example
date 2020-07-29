import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/27.
///

import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter_easyhub/flutter_easy_hub.dart';

///
/// Created by fgyong on 2020/7/27.
///

class BaseSocketRoute extends StatefulWidget {
  BaseSocketRoute({Key key}) : super(key: key);

  @override
  _BaseHttpDioRouteState createState() => _BaseHttpDioRouteState();
}

class _BaseHttpDioRouteState extends State<BaseSocketRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Socket'),
      ),
      body: _body(),
    );
  }

  String _string = '';
  Widget _body() {
    return Center(
      child: FlutterEasyHub(
        child: SingleChildScrollView(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(_string ?? ''),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getData();
    });
  }

  void _getData() async {
    var socket = await Socket.connect('github.com', 80);
    socket.write('GET / HTTP:/1.1');
    socket.write('Host:github.com');
    socket.write('Connection:close');
    socket.writeln();

    utf8.decoder.bind(socket).listen((event) {
      print(event);
      _string += event;
      setState(() {});
    });

    socket.flush();

    await socket.close(); //关闭
  }
}
