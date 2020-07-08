import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/8.
///

class BaseTouchHandle extends StatefulWidget {
  @override
  _BaseTouchHandleState createState() => _BaseTouchHandleState();
}

class _BaseTouchHandleState extends State<BaseTouchHandle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('原始手势处理'),
      ),
      body: _body(),
    );
  }

//定义一个状态，保存当前指针位置
  PointerEvent _event;
  Widget _body() {
    return Center(
      child: Listener(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.orange,
          alignment: Alignment.center,
          child: Text(_event.toString(minLevel: DiagnosticLevel.info)),
        ),
        onPointerCancel: (PointerCancelEvent event) {
          setState(() {
            _event = _event;
          });
        },
        onPointerDown: (PointerDownEvent ev) {
          setState(() {
            _event = ev;
          });
        },
        onPointerMove: (PointerMoveEvent ev) {
          setState(() {
            _event = ev;
          });
        },
      ),
    );
  }
}
