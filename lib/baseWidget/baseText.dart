import 'dart:developer';
import 'dart:io';
import 'dart:ui';

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
    var w = MediaQuery.of(context).size.width;
    TextSpan sp = TextSpan(children: [
      TextSpan(
        text: 'TextOverflow.ellipsisTextOverflow.elli  ',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      WidgetSpan(
          child: Container(
        child: Text(
          '我是结尾',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      )),
    ]);
    Widget ch = Text.rich(
      sp,
      maxLines: 2,
      textScaleFactor: _textScaleFactor,
      overflow: _overflow,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('text'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                color: Colors.redAccent,
              ),
              Expanded(
                  child: _buildStartLevelText(
                context,
                name: '仿照美团中间。。。后边再新增文字类型后边再新增文字类型后边再新增文字类型后边再新增文字类型',
                type: '类型',
              )),
              Container(
                width: 50,
                height: 50,
                color: Colors.redAccent,
              )
            ],
          ),
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
            child: ch,
            height: 150,
          ),
          Text('TextOverflow'),
          Padding(
            child: Row(
              children: <Widget>[
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
          Text('TextDecorationStyle'),
          Row(
            children: <Widget>[
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
          ),
          Container(
            color: Colors.redAccent,
            child: Container(
              width: 180,
              height: 100,
              child: CustomPaint(
                painter: _CustomPaint(),
              ),
            ),
          ),
          _TextSpan()
        ],
      ),
    );
  }

  Text _buildStartLevelText(BuildContext context,
      {String name, String type, int lines}) {
    double width = MediaQuery.of(context).size.width - 100;
    lines ??= 2;
    TextStyle textStyle1 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    TextStyle textStyle2 = TextStyle(fontSize: 11);
    try {
      TextSpan textSpan = TextSpan(
        children: [
          TextSpan(
              text: "$name  ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          TextSpan(text: type, style: TextStyle(fontSize: 11)),
        ],
      );

      TextPainter textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          maxLines: lines,
          ellipsis: '...');
      textPainter.layout(
        minWidth: 0,
        maxWidth: width,
      );

      String retName = name;

      while (textPainter.didExceedMaxLines == true &&
          name != null &&
          name.isNotEmpty) {
        log('didExceedMaxLines :$name');
        name = name.substring(0, name.length - 1);

        textSpan = TextSpan(
          children: [
            TextSpan(text: "$name...  ", style: textStyle1),
            TextSpan(text: type, style: textStyle2),
          ],
        );

        textPainter.text = textSpan;
        textPainter.layout(
          minWidth: 0,
          maxWidth: width,
        );
      }

      Text richText = Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: "$name${name == retName ? '' : '...'}  ",
                style: textStyle1),
            WidgetSpan(
                child: Container(
              margin: EdgeInsets.only(top: 3, bottom: (Platform.isIOS ? 0 : 1)),
              padding: const EdgeInsets.only(left: 0, right: 4),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 1.0),
                child: Text(
                  "${type ?? ""}",
                  style: textStyle2,
                ),
              ),
            )),
          ],
        ),
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        maxLines: lines,
      );
      return richText;
    } catch (e) {
      var richText = Text.rich(
        TextSpan(
          children: [
            TextSpan(text: "$name  ", style: textStyle1),
            WidgetSpan(
                child: Container(
              margin: EdgeInsets.only(top: 3, bottom: (Platform.isIOS ? 0 : 1)),
              padding: const EdgeInsets.only(left: 0, right: 4),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 1.0),
                child: Text(
                  "${type ?? ""}",
                  style: textStyle2,
                ),
              ),
            )),
          ],
        ),
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        maxLines: lines,
      );
      return richText;
    }
  }

  void _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch $url';
    }
  }
}

class _TextSpan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return __TextSpanState();
  }
}

class __TextSpanState extends State<_TextSpan> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    super.initState();
    log('__TextSpanState initState');
  }

  @override
  void dispose() {
    log('__TextSpanState dispose');
    super.dispose();
  }
}

class _LessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('_lessWidget');
  }
}

class _CustomPaint extends CustomPainter {
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  ParagraphBuilder builder;
  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 30,
    );
    final textSpan = TextSpan(
      text: 'Hello, world.',
      style: textStyle,
    );
    final textPainter = TextPainter(
        text: textSpan, textDirection: TextDirection.ltr, maxLines: 2);
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    // final offset = Offset(0, 0);
    // textPainter.paint(canvas, offset);

    builder = ParagraphBuilder(ParagraphStyle(
        fontSize: textStyle.fontSize,
        fontFamily: textStyle.fontFamily,
        fontStyle: textStyle.fontStyle,
        fontWeight: textStyle.fontWeight,
        textAlign: TextAlign.start,
        ellipsis: '...',
        maxLines: 2));

    String t = 'Paragraph123456789012';

    builder.addText('$t');

    Paragraph paragraph = builder.build()
      ..layout(ParagraphConstraints(width: size.width));

    if (paragraph.didExceedMaxLines) {
      while (true) {
        t = t.substring(0, t.length - 1);
        if (t == null || (t?.isEmpty ?? true)) {
          break;
        }
        var texts = paragraph.getBoxesForRange(t.length - 1, t.length).first;
        if (size.width - texts.right > 80) {
          break;
        }
        // print('$texts');
      }
    }
    builder = ParagraphBuilder(ParagraphStyle(
        fontSize: textStyle.fontSize,
        fontFamily: textStyle.fontFamily,
        fontStyle: textStyle.fontStyle,
        fontWeight: textStyle.fontWeight,
        textAlign: TextAlign.start,
        ellipsis: '...',
        maxLines: 2));
    builder.addText('$t...');
    paragraph = builder.build()
      ..layout(ParagraphConstraints(width: size.width));
    canvas.drawParagraph(paragraph, Offset(0, 0));

    // TextPainter textPainter = TextPainter()..layout(maxWidth: 100);
  }
}
