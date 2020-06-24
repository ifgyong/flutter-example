import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
          Container(
            child: Text(
              'text HelloWord',
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text(
              '加了style的文本',
              style: TextStyle(
                  fontFamily: 'Merriweather',
//                  package: 'flutter-example-git',
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
          ),
          Container(
            height: 30,
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Text.rich(TextSpan(
                text: '------textSpan-----',
                style: TextStyle(
                  fontSize: 20,
                ))),
          ),
          Text.rich(
            TextSpan(
                text: 'Jok Ma,hello!',
                style: TextStyle(
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                      text: 'Bo',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          backgroundColor: Colors.black12)),
                  TextSpan(
                      text: 'b,hello!',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.red,
                          backgroundColor: Colors.lightGreenAccent)),
                  TextSpan(
                      text: 'two line',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.red,
                          backgroundColor: Colors.lightGreenAccent,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                          decorationStyle: TextDecorationStyle.double)),
                  TextSpan(
                    text: '\n点击打开我 🖱http://www.fgyong.cn',
                    style: TextStyle(fontSize: 20, height: 2),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        _openUrl('http://www.fgyong.cn');
                      },
                  ),
                ]),
          ),
          DefaultTextStyle(
            //1.设置文本默认样式
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.start,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Jack  Ma"),
                Text("I am Ok"),
                Text(
                  "I am Jack",
                  style: TextStyle(
                    inherit: false, //2.不继承默认样式
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch $url';
    }
  }
}
