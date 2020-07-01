import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseScrollViewWheel extends StatefulWidget {
  BaseScrollViewWheelState createState() => BaseScrollViewWheelState();
}

class BaseScrollViewWheelState extends State<BaseScrollViewWheel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListWheelScrollView'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: _body()),
          Positioned.fill(
            child: _bottom(),
            bottom: 0,
          ),
        ],
      ),
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
        offAxisFraction: value, //左右偏移量
        /// 固定中间选中的的放大或者缩小操作
        magnification: value3 + 1,
        useMagnifier: true,

        /// list 弯曲度  [0,0.01]

        perspective: value2 / 100.0 == 0 ? 0.00000000001 : value2 / 100.0);
  }

  Widget _bottom() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('offAxisFraction'),
            CupertinoSlider(
                value: value,
                onChanged: (v) {
                  setState(() {
                    value = v;
                  });
                  print(v);
                }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('perspective'),
            CupertinoSlider(
                value: value2,
                onChanged: (v) {
                  setState(() {
                    value2 = v;
                  });
                  print(v);
                }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('magnification'),
            CupertinoSlider(
                value: value3,
                onChanged: (v) {
                  setState(() {
                    value3 = v;
                  });
                  print(v);
                }),
          ],
        )
      ],
    );
  }

  double value = 0;
  double value2 = 0;
  double value3 = 0;
}
