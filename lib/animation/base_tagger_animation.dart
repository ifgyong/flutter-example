import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/21.

///

class BaseTaggerAnimation extends StatefulWidget {
  BaseTaggerAnimation({Key key}) : super(key: key);

  @override
  _BaseTaggerAnimationState createState() => _BaseTaggerAnimationState();
}

class _BaseTaggerAnimationState extends State<BaseTaggerAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _radius;
  Animation<double> _height;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 4000))
          ..repeat();
    _radius = Tween<double>(begin: 0, end: 100).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 0.5, curve: Curves.easeIn)));
    _height = Tween<double>(begin: 1, end: 0.5).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.5, 1.0, curve: Curves.bounceOut),
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('交织动画'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    double height = 200;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (ctx, child) {
        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(_radius.value)),
            child: Container(
              width: height * _height.value,
              height: height * _height.value,
              color: Colors.orange,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
