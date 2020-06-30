import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseScrollViewWheel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListWheelScrollView'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    List<Widget> list = new List();

    for (int i = 0; i < 100; i++) {
      Widget widget = Container(
        width: 300,
        height: 100,
        color: Colors.primaries[i % Colors.primaries.length],
      );
      list.add(widget);
    }
    return ListWheelScrollView(
        itemExtent: 100,
        children: list,
        offAxisFraction: 0, //左右偏移量
        /// 固定中间选中的的放大或者缩小操作
//        magnification: 1.2,
//        useMagnifier: true,
        /// list 弯曲度  [0,0.01]

        perspective: 0.001);
  }
}
