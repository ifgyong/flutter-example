import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/15.
///

class BaseAnimation extends StatefulWidget {
  @override
  _BaseAnimationState createState() => _BaseAnimationState();
}

class _BaseAnimationState extends State<BaseAnimation>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
//    /// 在1000毫秒内生成值
//    final AnimationController _animationController = AnimationController(
//        vsync: this, duration: Duration(milliseconds: 1000));
//
//    /// 生成值是由红色渐变为绿色
//    final Animation _animation =
//        ColorTween(begin: Colors.red, end: Colors.green)
//            .animate(_animationController);
//
//    /// 生成的曲线规则是正向是 Curves.bounceInOut，逆向是Curves.linear
//    final Animation curv = CurvedAnimation(
//        parent: _animation,
//        curve: Curves.bounceInOut,
//        reverseCurve: Curves.linear);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: _body(),
    );
  }

  int count = 0;
  Widget _body() {
    count++;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ScaleANimationRoute(
            key: ObjectKey(count),
          ),
          OutlineButton(
            child: Text('刷新'),
            onPressed: () {
              setState(() {});
            },
          )
        ],
      ),
    );
  }
}

/// 自定义了一个曲线
class SinLine extends Curve {
  @override
  double transform(double t) {
    return sin(t * pi / 2);
  }
}

class ScaleANimationRoute extends StatefulWidget {
  ScaleANimationRoute({Key key}) : super(key: key);
  @override
  _ScaleANimationRouteState createState() => _ScaleANimationRouteState();
}

class _ScaleANimationRouteState extends State<ScaleANimationRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: 1000),
        lowerBound: 0.0,
        upperBound: 1.0,
        vsync: this);
//      ..addStatusListener((status) {
//        if (status == AnimationStatus.completed) {
//          /// 如果结束，则反向运动
//          _animationController.reverse();
//        } else if (status == AnimationStatus.dismissed) {
//          // 如果反向结束 则正向开始
//          _animationController.forward();
//        }
//      });

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);
    _animation = new Tween<Offset>(begin: Offset(0, 0), end: Offset(1.0, 1.0))
        .animate(_animation);

    ///正向启动
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Container(
        color: Colors.lightBlueAccent,
        width: 100,
        height: 100,
      ),
    );
  }
//  @override
//  Widget build(BuildContext context) {
//
//    return AnimatedLessWidget(
//      child: Text(
//        '弹簧动画',
//      ),
//      animation: _animation,
//    );
//  }
//  @override
//  Widget build(BuildContext context) {
//    print('刷新一次');
//    int count = 0;
//    return AnimatedBuilder(
//      child: AnimateWidgetFrame(
//        animation: _animation,
//      ),
//      animation: _animation,
//      builder: (ctx, child) {
//        print('动画刷新次数:${count++}');
//        return Container(
//          width: 100 * _animation.value,
//          height: 100 * _animation.value,
//          color: Colors.lightBlueAccent,
//        );
//      },
//    );
//  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }
}

class AnimateWidgetFrame extends AnimatedWidget {
  AnimateWidgetFrame({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
      width: 100 * animation.value,
      height: 100 * animation.value,
      color: Colors.lightBlueAccent,
    );
  }
}

class AnimatedLessWidget extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  AnimatedLessWidget({this.child, this.animation});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      child: child,
      animation: animation,
      builder: (ctx, w) {
        return Container(
          width: 100 * animation.value,
          height: 100 * animation.value,
          color: Colors.lightBlueAccent,
          child: w,
        );
      },
    );
  }
}
