import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseNetWorkConnect extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BaseNetWorkConnectState();
  static String get routeName => '/_BaseNetWorkConnectState';
}

class _BaseNetWorkConnectState extends State<BaseNetWorkConnect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BaseNetWorkConnect'),
      ),
      body: _body(),
    );
  }

  String ret = '';

  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [TextButton(onPressed: check, child: Text('刷新 $ret'))],
      ),
    );
  }

  Connectivity connect;
  @override
  void initState() {
    super.initState();
    connect = Connectivity();
    check();
    connect.onConnectivityChanged.listen((event) {
      statusToStr(event);
      if (mounted) setState(() {});
    }, onDone: () {
      print('done');
    }, onError: (error) {
      print(error);
    });
  }

  void check() async {
    connect.checkConnectivity().then((event) {
      statusToStr(event);
      if (mounted) setState(() {});
    });
  }

  String statusToStr(ConnectivityResult event) {
    switch (event) {
      case ConnectivityResult.none:
        ret = 'none';
        break;
      case ConnectivityResult.wifi:
        ret = 'wifi';
        break;
      case ConnectivityResult.mobile:
        ret = 'mobile';
        break;
    }
    return ret;
  }
}
