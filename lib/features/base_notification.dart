import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/9.
///

class BaseNotificationPage extends StatefulWidget {
  @override
  _BaseNotificationPageState createState() => _BaseNotificationPageState();
}

class _BaseNotificationPageState extends State<BaseNotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('通知'),
      ),
      body: _body2(),
    );
  }

  Widget _body() {
    return NotificationListener<ScrollStartNotification>(
      onNotification: (notification) {
        switch (notification.runtimeType) {
          case ScrollStartNotification:
            print("开始滚动");
            break;
          case ScrollUpdateNotification:
            print("正在滚动");
            break;
          case ScrollEndNotification:
            print("滚动停止");
            break;
          case OverscrollNotification:
            print("滚动到边界");
            break;
        }
        return true;
      },
      child: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Container(
            height: 2000,
            width: 400,
            color: Colors.orange,
          ),
        ),
      ),
    );
  }

  int _code = 0;
  Widget _body2() {
    return NotificationListener<FyNotification>(
      onNotification: (notification) {
        print('我是外层监听');
        return false;
      },
      child: NotificationListener<FyNotification>(
        onNotification: (FyNotification notification) {
          setState(() {
            _code = notification.code;
          });
          print('我是内层监听');
          return false;
        },
        child: Center(
          child: Column(
            children: <Widget>[
              Builder(
                builder: (context) {
                  return OutlineButton(
                    child: Text('发送通知'),
                    onPressed: () {
                      FyNotification(code: 200).dispatch(context);
                    },
                  );
                },
              ),
              Text('$_code'),
            ],
          ),
        ),
      ),
    );
  }
}

class FyNotification extends Notification {
  int code;
  FyNotification({this.code});
}
