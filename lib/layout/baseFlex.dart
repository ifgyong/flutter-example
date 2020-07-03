import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseFlex extends StatefulWidget {
  /// FractionallySizedBox 按照父容器的大小的 比例展示子组件
  ///
  BaseFlexState createState() => BaseFlexState();
}

class BaseFlexState extends State<BaseFlex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('弹性布局'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('MainAxisAlignment.start'),
            _bd(MainAxisAlignment.start, CrossAxisAlignment.start),
            Text('MainAxisAlignment.center'),
            _bd(MainAxisAlignment.center, CrossAxisAlignment.start),
            Text('MainAxisAlignment.end'),
            _bd(MainAxisAlignment.end, CrossAxisAlignment.start),
            Text('MainAxisAlignment.spaceAround'),
            _bd(MainAxisAlignment.spaceAround, CrossAxisAlignment.start),
            Text('MainAxisAlignment.spaceEvenly'),
            _bd(MainAxisAlignment.spaceEvenly, CrossAxisAlignment.start),
            Text('MainAxisAlignment.spaceBetween'),
            _bd(MainAxisAlignment.spaceBetween, CrossAxisAlignment.start),
            _bd2(),
            _bd3(),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: OutlineButton(
                    child: Text('Expanded btn'),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            OutlineButton(
              onPressed: () {},
              child: Text('btn'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      child: FractionallySizedBox(
        widthFactor: 0.5,
        heightFactor: 0.5,
        child: Container(
          color: Colors.deepOrangeAccent,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 0.5,
            child: Container(
              color: Colors.orange,
            ),
          ),
        ),
      ),
    );
  }

  Widget _bd(MainAxisAlignment mainAxisAlignment, CrossAxisAlignment cl) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Flex(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: cl,
        textDirection: TextDirection.ltr,
        direction: Axis.horizontal,
        children: <Widget>[
          Container(
            height: 30,
            width: 100,
            child: Text('1'),
            alignment: Alignment.center,
            color: Colors.red,
          ),
          Container(
            alignment: Alignment.center,
            height: 30,
            width: 100,
            child: Text('2'),
            color: Colors.red,
          ),
          Container(
            alignment: Alignment.center,
            child: Text('3'),
            height: 30,
            width: 100,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _bd2() {
    return Container(
        height: 30,
        child: Row(children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.red,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.orange,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.blue,
            ),
          )
        ]));
  }

  Widget _bd3() {
    return Container(
        height: 30,
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Row(children: <Widget>[
          Container(
            width: 50,
            color: Colors.red,
          ),
          Spacer(
            flex: 1,
          ),
          Container(
            width: 50,
            color: Colors.red,
          ),
          Spacer(
            flex: 2,
          ),
          Container(
            width: 50,
            color: Colors.red,
          ),
        ]));
  }

  Widget _bd4() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: OutlineButton(
              child: Text('btn'),
            ),
          ),
        ],
      ),
    );
  }
}
