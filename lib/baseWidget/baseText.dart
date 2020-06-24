import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseWidgetTextPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BaseWidgetTextPageState();
  }
}

class BaseWidgetTextPageState extends State<BaseWidgetTextPage> {
  double _textScaleFactor = 2.0; //字体放大倍数
  TextOverflow _overflow = TextOverflow.visible;
  TextDecorationStyle _decorationStyle = TextDecorationStyle.dashed;
  @override
  Widget build(BuildContext context) {
    _textScaleFactor = 2.0;
    return Scaffold(
      appBar: AppBar(
        title: Text('text'),
      ),
      body: Column(
        children: <Widget>[
//          Container(
//            child: Text(
//              'text HelloWord',
//              textAlign: TextAlign.left,
//            ),
//          ),
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text(
              '加了style的文本',
              style: TextStyle(
                  color: Colors.red,
                  letterSpacing: 1,
                  wordSpacing: 3,
                  fontSize: 30,
                  height: 1.4,
                  background: new Paint()..color = Colors.black12,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                  decorationStyle: _decorationStyle),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'TextOverflow.ellipsis' * 10,
              textAlign: TextAlign.left,
              maxLines: 2,
              overflow: _overflow,
              textScaleFactor: _textScaleFactor,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            height: 150,
          ),
          Padding(
            child: Row(
              children: <Widget>[
                Text('TextOverflow'),
                CupertinoSegmentedControl<TextOverflow>(
                  children: {
                    TextOverflow.ellipsis: Text('ellipsis'),
                    TextOverflow.clip: Text('clip'),
                    TextOverflow.fade: Text('fade'),
                    TextOverflow.visible: Text('visible'),
                  },
                  onValueChanged: (value) {
                    setState(() {
                      _overflow = value;
                    });
                  },
                  selectedColor: Theme.of(context).primaryColor,
                  groupValue: _overflow,
                )
              ],
            ),
            padding: EdgeInsets.all(10),
          ),
          Row(
            children: <Widget>[
              Text('TextDecorationStyle'),
              CupertinoSegmentedControl<TextDecorationStyle>(
                children: {
                  TextDecorationStyle.double: Text('double'),
                  TextDecorationStyle.wavy: Text('wavy'),
                  TextDecorationStyle.dashed: Text('dashed'),
                  TextDecorationStyle.solid: Text('solid'),
                  TextDecorationStyle.dotted: Text('dotted'),
                },
                onValueChanged: (value) {
                  setState(() {
                    _decorationStyle = value;
                  });
                },
                selectedColor: Theme.of(context).primaryColor,
                groupValue: _decorationStyle,
              )
            ],
          )
        ],
      ),
    );
  }
}
