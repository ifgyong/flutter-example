import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/27.
///

class BaseHttpClientRoute extends StatefulWidget {
  BaseHttpClientRoute({Key key}) : super(key: key);

  @override
  _BaseHttpClientRouteState createState() => _BaseHttpClientRouteState();
}

class _BaseHttpClientRouteState extends State<BaseHttpClientRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HttpClient'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        children: <Widget>[],
      ),
    );
  }

  void _send() async {
    HttpClient httpClient = new HttpClient();
    Uri uri = Uri(
        scheme: 'https',
        host: 'flutterchine.club',
        queryParameters: {'a': '1', 'b': '2'});
    HttpClientRequest request = await httpClient.getUrl(uri);
  }
}
