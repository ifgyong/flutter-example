import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/3.
///
class BaseWillPop extends StatefulWidget {
  @override
  _BaseWillPopState createState() => _BaseWillPopState();
}

class _BaseWillPopState extends State<BaseWillPop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BaseWillPop'),
      ),
      body: WillPopScope(
          child: _body(),
          onWillPop: () async {
            //code
            showDialog(
                context: context,
                builder: (ctx) => CupertinoAlertDialog(
                      title: Text('提示'),
                      content: Text('真的退出吗？'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('真的 退出了'),
                          onPressed: () {
                            Navigator.of(context).popUntil((route) {
                              return route.isFirst;
                            });
                          },
                        ),
                        FlatButton(
                          child: Text('暂不退出了'),
                          onPressed: () {
                            Navigator.maybePop(context);
                          },
                        ),
                      ],
                    ));
            return false;
          }),
    );
  }

  Widget _body() {
    return Container();
  }
}
