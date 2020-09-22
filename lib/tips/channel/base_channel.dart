import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
/// Created by fgyong on 2020/9/7.
///

class BaseChannelRoute extends StatefulWidget {
  BaseChannelRoute({Key key}) : super(key: key);

  @override
  _BaseChannelRouteState createState() => _BaseChannelRouteState();
  static String get routeName => 'BaseChannelRoute';
}

class _BaseChannelRouteState extends State<BaseChannelRoute> {
  static const platform = const MethodChannel('samples.flutter.io/battery');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('获取电量'),
      ),
      body: _body(),
    );
  }

  String _string = '';
  Widget _body() {
    return Column(
      children: [
        OutlineButton(
          child: Text('获取电量'),
          onPressed: _get,
        ),
        Text('$_string')
      ],
    );
  }

  Future<void> _get() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      setState(() {
        _string = result.toString();
      });
    } on PlatformException catch (e) {
      print('$e');
    }
  }
}
