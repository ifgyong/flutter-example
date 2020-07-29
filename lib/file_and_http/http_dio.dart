import 'dart:convert';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:flutter_easyhub/flutter_easy_hub.dart';
import 'package:fluttertest01/file_and_http/model/git_model.dart';
import 'package:fluttertest01/generated/json/base/json_convert_content.dart';

///
/// Created by fgyong on 2020/7/27.
///

class BaseHttpDioRoute extends StatefulWidget {
  BaseHttpDioRoute({Key key}) : super(key: key);

  @override
  _BaseHttpDioRouteState createState() => _BaseHttpDioRouteState();
}

class _BaseHttpDioRouteState extends State<BaseHttpDioRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dio'),
      ),
      body: _body(),
    );
  }

  Dio _dio = new Dio();
  String _string;
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
    EasyHub.showHub();
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      // config the http client
      client.findProxy = (uri) {
        return "PROXY localhost:1088";
      };
      // you can also create a HttpClient to dio
      // return HttpClient();
    };
    Response res = await _dio.get('https://api.github.com/users/ifgyong/repos');
    List<dynamic> list = res.data;
    List<GitModel> gitList = [];
    if (res.data is List) {
      (res.data as List).forEach((element) {
        GitModel modl = JsonConvert.fromJsonAsT<GitModel>(element);
        gitList.add(modl);
      });
      print('${gitList.length}');
    }

//    Map<String, dynamic> mapret = convert.jsonDecode(res.data);
    setState(() {
      _string = res.data.toString();
    });
    EasyHub.dismiss();
    print('res.data${list.toString()}');
  }
}
