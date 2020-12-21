import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetRoute extends StatefulWidget {
  GetRoute({Key key}) : super(key: key);

  @override
  _GetRouteState createState() => _GetRouteState();
  static String get routeName => "GetRoute";
}

class _GetRouteState extends State<GetRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('路由跳转'),
      ),
      body: Center(
        child: Column(
          children: [
            OutlineButton(
              child: Text('to 下一个页面'),
              onPressed: _to,
            ),
            OutlineButton(
              child: Text('back 返回'),
              onPressed: _back,
            ),
            OutlineButton(
              child: Text('off 替换当前路由'),
              onPressed: _off,
            ),
            OutlineButton(
              child: Text('offAll 返回到顶部'),
              onPressed: _offAll,
            ),
            OutlineButton(
              child: Text('off Until 返回到符合条件的路由'),
              onPressed: _offUntil,
            ),
          ],
        ),
      ),
    );
  }

  /// 新打开页面
  void _to() {
    Get.to(GetRoute(),
        preventDuplicates: false, transition: Transition.topLevel, duration: Duration(seconds: 1));
  }

  /// 返回
  void _back() {
    Get.back();
  }

  void _off() {
    Get.off(GetRoute(), preventDuplicates: false);
  }

  void _offAll() {
    Get.offAll(GetRoute());
  }

  void _offUntil() {
    Get.offUntil(MaterialPageRoute(builder: (_) => GetRoute()), (route) => false);
  }
}

class GetRouteController extends GetxController {}
