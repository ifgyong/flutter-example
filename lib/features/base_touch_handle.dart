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
      body: _body2(),
    );
  }

//定义一个状态，保存当前指针位置
  PointerEvent _event;
  String _eventState = '';
  Widget _body() {
    return Center(
      child: Listener(
        child: Center(
          child: Column(
            children: <Widget>[
              IgnorePointer(
                child: Listener(
                  child: SizedBox(
                    height: 50,
                    child: Container(
                      color: Colors.red,
                      height: 50,
                      width: 100,
                      child: Text(_eventState),
                    ),
                  ),
                  onPointerDown: (PointerDownEvent ev) {
                    setState(() {
                      _event = ev;
                      _eventState = '子树 -> 手势按下';
                    });
                  },
                ),
              )
            ],
          ),
        ),
        onPointerUp: (PointerUpEvent ev) {
          setState(() {
            _event = ev;
            _eventState = '抬起手势';
          });
        },
      ),
    );
  }

  Widget _body2() {
    return Center(
      child: Listener(
        child: Center(
          child: Container(
            color: Colors.red,
            height: 200,
            width: 100,
            child: Stack(
              children: <Widget>[
                Listener(
                  child: ConstrainedBox(
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Text(_eventState),
                    ),
                    constraints: BoxConstraints.tight(Size(100.0, 100.0)),
                  ),
                  onPointerDown: (PointerDownEvent ev) {
                    setState(() {
                      _eventState = '点击 蓝色';
                    });
                  },
                ),
                Listener(
                  child: ConstrainedBox(
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.orange),
                      child: Text(_eventState),
                    ),
                    constraints: BoxConstraints.tight(Size(100.0, 50.0)),
                  ),
                  onPointerDown: (PointerDownEvent ev) {
                    setState(() {
                      _eventState = '点击橘黄色区域';
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        behavior: HitTestBehavior.deferToChild,
        onPointerUp: (PointerUpEvent ev) {
          setState(() {
            _event = ev;
            _eventState = '抬起手势';
          });
        },
      ),
    );
  }
}
