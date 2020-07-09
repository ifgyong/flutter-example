import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/9.
///

class BaseEventBus extends StatefulWidget {
  @override
  _BaseEventBusState createState() => _BaseEventBusState();
}

class _BaseEventBusState extends State<BaseEventBus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('事件总线'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        children: <Widget>[
          Text(_str),
          OutlineButton(
            onPressed: () {
//              _bus.fire('test', '全局调用了一次哦');

              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (c) => _Page2()));
            },
            child: Text('点我push new page'),
          )
        ],
      ),
    );
  }

  String _str = '';
  FYEventBus _bus;
  @override
  void initState() {
    _bus = FYEventBus()
      ..on('test', (string) {
        setState(() {
          _str += string;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _bus.off('test', null);
    super.dispose();
  }
}

class _Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('过来传值了'),
      ),
      body: _body(),
    );
  }

  FYEventBus _bus = FYEventBus();
  Widget _body() {
    return Center(
      child: Column(
        children: <Widget>[
          OutlineButton(
            onPressed: () {
              _bus.fire('test', '\n点我发送请求A');
            },
            child: Text('点我发送请求A'),
          ),
          OutlineButton(
            onPressed: () {
              _bus.fire('test', '\n点我发送请求B');
            },
            child: Text('点我发送请求B'),
          )
        ],
      ),
    );
  }
}

typedef EventBusCallback = void Function(Object object);

class FYEventBus {
  static FYEventBus _bus = new FYEventBus._();
  FYEventBus._();

  /// 工厂构造 单例模式
  factory FYEventBus() => _bus;

  //保存全局
  var _emap = new Map<Object, List<EventBusCallback>>();

  ///   监听回调
  void on(eventName, EventBusCallback callback) {
    if (eventName == null || callback == null) return;
    _emap[eventName] ??= new List();
    if (_emap[eventName].contains(callback) == false) {
      _emap[eventName].add(callback);
    }
  }

  /// 删除回调
  void off(eventName, EventBusCallback callback) {
    if (eventName == null || callback == null) return;
    if (callback == null) {
      _emap[eventName] = null;
    } else {
      _emap[eventName].remove(callback);
    }
  }

  /// 发送回调
  void fire(eventName, [arg]) {
    if (eventName == null) return;
    var list = _emap[eventName];
    if (list == null) return;
    for (var j = list.length - 1; j >= 0; --j) {
      var o = list[j];
      o(arg);
    }
  }
}
