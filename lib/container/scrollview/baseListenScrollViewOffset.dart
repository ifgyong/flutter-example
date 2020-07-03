import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/3.
///

class BaseListenScrollView extends StatefulWidget {
  @override
  _BaseListenScrollViewState createState() => _BaseListenScrollViewState();
}

class _BaseListenScrollViewState extends State<BaseListenScrollView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('监听滚动'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CupertinoScrollbar(
//          isAlwaysShown: false,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification no) {
              var v = no.metrics.pixels / no.metrics.maxScrollExtent;
              setState(() {
                _value = v * 100;
              });
              return true;
            },
            child: ListView.builder(
              itemBuilder: _child,
              controller: _controller,
              itemCount: 50,
            ),
          ),
        ),
        CircleAvatar(
          radius: 40,
          child: Container(
            child: Text('${_value.toStringAsFixed(2)}%'),
          ),
        )
      ],
    );
  }

  Widget _child(ctx, int index) {
    return Container(
      height: 80,
      color: Colors.primaries[index % Colors.primaries.length],
    );
  }

  ScrollController _controller;
  double _value = 0;
  @override
  void initState() {
    _controller = new ScrollController()
      ..addListener(() {
        print('${_controller.offset}');
      });
    super.initState();
  }
}
