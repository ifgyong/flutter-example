import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseDecoratedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('装饰容器'),
      ),
      body: Center(
        child: CupertinoScrollbar(
            child: SingleChildScrollView(
          child: _body(),
        )),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('RadialGradient'),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blue,
            gradient: RadialGradient(
                colors: [Colors.orange, Colors.black12, Colors.blue]),
          ),
        ),
        Text('SweepGradient'),
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue,
              gradient: SweepGradient(
                  colors: [Colors.orange, Colors.black12, Colors.blue]),
            ),
          ),
        ),
        Text('LinearGradient'),
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue,
              gradient: LinearGradient(
                  colors: [Colors.orange, Colors.black12, Colors.blue]),
            ),
          ),
        ),
        Text('BoxShape.circle'),
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Text('BoxShape.rectangle  BorderRadius.all(Radius.circular(20))'),
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      color: Colors.black12,
                      blurRadius: 10.0,
                      spreadRadius: 3)
                ]),
          ),
        ),
        Text('DecorationImage and BoxShadow'),
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                backgroundBlendMode: BlendMode.darken,
                shape: BoxShape.rectangle,
                image: DecorationImage(
                    image: AssetImage('img/fl.png'), fit: BoxFit.contain),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(-10, -10),

                      ///左上角偏移
                      color: Colors.black12, //背景颜色
                      blurRadius: 2.0, //模糊度 2就是2个像素变成一个像素
                      spreadRadius: 3), //外扩范围
                  BoxShadow(
                      offset: Offset(10, 10),
                      color: Colors.black12,
                      blurRadius: 2.0,
                      spreadRadius: 3)
                ]),
          ),
        ),
        Text('child and image and color'),
        Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                    image: AssetImage('img/fl.png'), fit: BoxFit.contain),
              ),
              child: FlutterLogo(
                size: 20,
              ),
            )),
        Text('Border'),
        Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                border: Border.fromBorderSide(BorderSide(
                  color: Colors.orange,
                  width: 10,
                )), //
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: FlutterLogo(
                size: 20,
              ),
            ))
      ],
    );
  }
}
