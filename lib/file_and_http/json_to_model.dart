import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:fluttertest01/file_and_http/model/user.dart';
import 'package:fluttertest01/file_and_http/model/user_entity.dart';
import 'package:fluttertest01/generated/json/base/json_convert_content.dart';

///
/// Created by fgyong on 2020/7/27.
///

class BaseJsonToModelRoute extends StatefulWidget {
  BaseJsonToModelRoute({Key key}) : super(key: key);

  @override
  _BaseJsonToModelRouteState createState() => _BaseJsonToModelRouteState();
}

class _BaseJsonToModelRouteState extends State<BaseJsonToModelRoute> {
  String jsonStr = '{"list":[{"name":"Jack Ma"},{"name":"QiangDong liu"}]}';
  @override
  void initState() {
//    List items = json.decode(jsonStr);
//
//    print(items[0]['name']);
    super.initState();
  }

  String _string = '姓名：\n';
  void _toModel() {
    UserEntity list = JsonConvert.fromJsonAsT<UserEntity>(json.decode(jsonStr));
    list.xList.forEach((element) {
      _string += element.name;
      _string += '\n';
      print(element.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    _toModel();
    return Scaffold(
      appBar: AppBar(
        title: Text('json to model'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        children: <Widget>[Text(_string)],
      ),
    );
  }
}
