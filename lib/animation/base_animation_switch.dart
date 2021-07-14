import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/23.
///

class BaseAnimationSwitcher extends StatefulWidget {
  BaseAnimationSwitcher({Key key}) : super(key: key);

  @override
  _BaseAnimationSwitcherState createState() => _BaseAnimationSwitcherState();
}

class _BaseAnimationSwitcherState extends State<BaseAnimationSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimationSwitcher'),
      ),
      body: _body(),
    );
  }

  int _count = 0;
  int _count2 = 0;

  Ax _ax = Ax.ttb;
  void _add() {
    setState(() {
      _count += 1;
    });
  }

  void _plus() {
    setState(() {
      _count2 += 1;
    });
  }

  void _down() {
    setState(() {
//      _ax = Ax.ttb;
      _count -= 1;
    });
  }

  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            child: AnimatedSwitcher(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                key: Key(_count.toString()),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.orange,
                  alignment: Alignment.center,
                  child: Text(
                    '$_count',
                  ),
                ),
              ),
              duration: Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return MySliderTransitiion(
                  position: animation,
                  child: child,
                  ax: _ax,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: Text('+'),
                onPressed: _add,
              ),
              TextButton(child: Text('-'), onPressed: _down),
            ],
          ),
          _row(),
          ClipRRect(
            child: AnimatedSwitcher(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                key: Key(_count2.toString()),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.accents[_count2 % Colors.accents.length],
                  alignment: Alignment.center,
                  child: Text(
                    '$_count2',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              duration: Duration(milliseconds: 1300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          ),
          TextButton(
            child: Text('一个widget过度\n成另外一个widget\n+数字'),
            onPressed: _plus,
          ),
        ],
      ),
    );
  }

  Widget _row() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        OutlineButton(
          child: Text('↑'),
          textColor: _ax == Ax.btt ? Colors.red : Colors.black,
          onPressed: () {
            setState(() {
              _ax = Ax.btt;
            });
          },
        ),
        OutlineButton(
          child: Text('→'),
          textColor: _ax == Ax.ltr ? Colors.red : Colors.black,
          onPressed: () {
            setState(() {
              _ax = Ax.ltr;
            });
          },
        ),
        OutlineButton(
          child: Text('↓'),
          textColor: _ax == Ax.ttb ? Colors.red : Colors.black,
          onPressed: () {
            setState(() {
              _ax = Ax.ttb;
            });
          },
        ),
        OutlineButton(
          child: Text('←'),
          textColor: _ax == Ax.rtl ? Colors.red : Colors.black,
          onPressed: () {
            setState(() {
              _ax = Ax.rtl;
            });
          },
        )
      ],
    );
  }
}

enum Ax {
  ltr,
  rtl,
  ttb,
  btt,
}

// ignore: must_be_immutable
class MySliderTransitiion extends AnimatedWidget {
  final Widget child;
  final Ax ax;
  Tween<Offset> _tween;
  MySliderTransitiion(
      {Key key,
      @required Animation<double> position,
      this.child,
      this.ax = Ax.btt})
      : assert(position != null),
        super(key: key, listenable: position) {
    /// 偏移在内部处理 每个方向的偏移量都不一样，
    /// 需要根据方向来指定偏移量
    switch (this.ax) {
      case Ax.btt:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case Ax.ltr:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case Ax.ttb:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case Ax.rtl:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }
  Animation<double> get position => listenable;
  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);

    /// 根据 动画的执行正向和反向来调节 坐标位置
    if (position.status == AnimationStatus.reverse) {
      switch (this.ax) {
        case Ax.ltr:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case Ax.rtl:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case Ax.ttb:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case Ax.btt:
          offset = Offset(offset.dx, -offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      child: child,
    );
  }
}
