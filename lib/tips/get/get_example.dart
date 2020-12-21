import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest01/tips/get/get_list_page.dart';
import 'package:fluttertest01/tips/get/get_login_page.dart';
import 'package:fluttertest01/tips/get/get_route.dart';
import 'package:fluttertest01/tips/get/get_store.dart';
import 'package:get/get.dart';

///
/// Created by fgyong on 2020/10/22.
///

class BaseGetPage extends StatefulWidget {
  BaseGetPage({Key key}) : super(key: key);

  @override
  _BaseGetPageState createState() => _BaseGetPageState();
  static get routeName => '/getPage';
}

class _BaseGetPageState extends State<BaseGetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('get'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlineButton(
          child: Text('get 数字加减'),
          onPressed: _pushNumber,
        ),
        OutlineButton(
          child: Text('show SnackBar top'),
          onPressed: () {
            Get.snackbar(
                "Hey i'm a Get SnackBar!", // title
                "It's unbelievable! I'm using SnackBar without context, without boilerplate, without Scaffold, it is something truly amazing!", // message
                icon: Icon(Icons.alarm),
                shouldIconPulse: true,
                onTap: null,
                barBlur: 20,
                isDismissible: true,
                duration: Duration(seconds: 3),
                snackPosition: SnackPosition.TOP);
          },
        ),
        OutlineButton(
          child: Text('show SnackBar BOTTOM'),
          onPressed: () {
            Get.snackbar(
                "Hey i'm a Get SnackBar!", // title
                "It's unbelievable! I'm using SnackBar without context, without boilerplate, without Scaffold, it is something truly amazing!", // message
                icon: Icon(Icons.alarm),
                shouldIconPulse: true,
                onTap: null,
                barBlur: 20,
                isDismissible: true,
                duration: Duration(seconds: 3),
                snackPosition: SnackPosition.BOTTOM);
          },
        ),
        Text('屏幕宽:${Get.width} 高:${Get.height}'),
        OutlineButton(
          child: Text('dialog'),
          onPressed: () {
            Get.dialog(Text('dialog'));
            Future.delayed(Duration(seconds: 2)).then((value) => Get.back());
          },
        ),
        OutlineButton(
          child: Text('bottomSheet'),
          onPressed: () {
            Get.bottomSheet(Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(leading: Icon(Icons.music_note), title: Text('Music'), onTap: () => {}),
                  ListTile(
                    leading: Icon(Icons.videocam),
                    title: Text('Video'),
                    onTap: () => {},
                  ),
                ],
              ),
            ));
          },
        ),
        Obx(() => Text(c.count.toString())),

        _gotoList(),
        _login(), _route(), _store()
        // ObxValue((var value) => Text('${value.toString()}'), c),
      ],
    );
  }

  Widget _gotoList() => OutlineButton(
        child: Text('goto list 列表展示'),
        onPressed: () {
          Get.toNamed(GetListPageRoute.routeName);
        },
      );

  Widget _login() => OutlineButton(
        child: Text('get 登陆 全过程'),
        onPressed: () {
          Get.to(GetLoginPage());
        },
      );

  Widget _route() => OutlineButton(
        child: Text('get 路由切换'),
        onPressed: () {
          Get.to(GetRoute());
        },
      );

  Widget _store() => OutlineButton(
        child: Text('get 存储'),
        onPressed: () {
          Get.to(GetStoreRoute());
        },
      );

  void _pushNumber() {
    c.increment();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<Controller>();
    Get.reset(clearFactory: true);
    super.dispose();
  }

  final Controller c = Get.put(Controller());
}

class Controller extends GetxController {
  var count = 0.obs;
  increment() => count++;
  @override
  void onClose() {
    printInfo(info: 'Controller close');
    super.onClose();
  }
}
