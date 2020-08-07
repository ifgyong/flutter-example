import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/8/7.
///

class FYTabbarWidget extends StatefulWidget {
  FYTabbarWidget({Key key}) : super(key: key);

  @override
  _FYTabbarWidgetState createState() => _FYTabbarWidgetState();
}

class _FYTabbarWidgetState extends State<FYTabbarWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tabbar'),
      ),
      body: _body(),
    );
  }

  bool _isStop = false;

  Widget _body() {
    return Center(
      child: Column(
        children: <Widget>[
          FlatButton(
            child: Text(
              'push stop',
            ),
            onPressed: () {
              setState(() {
                _isStop = !_isStop;
              });
            },
          ),
          FYSoundWidget(
            color: Colors.green,
            bgColor: Colors.black12,
            stop: _isStop,
            stopColor: Colors.black12,
            lineWidth: 2,
            radius: 300,
            lines: 10,
          )
        ],
      ),
    );
  }

  AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
    );
    super.initState();
  }
}

class FYSoundWidget extends StatefulWidget {
  Color color;
  Color bgColor;
  Color stopColor;
  bool stop;
  double radius;
  double lineWidth;
  double startAngle, sweepAngle;
  int lines;

  FYSoundWidget(
      {Key key,
      this.color,
      this.bgColor,
      @required this.stop,
      this.stopColor,
      this.radius,
      this.lineWidth,
      this.startAngle,
      this.sweepAngle,
      this.lines}) {
    this.color ??= Colors.green;
    stopColor ??= Colors.black12;
    radius ??= 50;
    bgColor ??= Colors.black12;
    lineWidth ??= 4;
  }
  @override
  _FYSoundWidgetState createState() => _FYSoundWidgetState();
}

class _FYSoundWidgetState extends State<FYSoundWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return Center(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (ctx, child) {
          return CustomPaint(
            painter: _CustomSoundWidget(
                value: _animationController.value,
                color: widget.color,
                bgColor: widget.bgColor,
                stop: widget.stop,
                stopColor: widget.stopColor,
                lineWidth: widget.lineWidth,
                lines: widget.lines),
            size: Size(widget.radius, widget.radius),
          );
        },
      ),
    );
  }

  AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _CustomSoundWidget extends CustomPainter {
  double value;
  double lineWidth;
  Color color;
  Color bgColor;
  Color stopColor;
  bool stop;
  double startAngle, sweepAngle;
  int lines;

  _CustomSoundWidget(
      {this.value = 0.0,
      this.color,
      this.bgColor,
      this.stop,
      this.stopColor,
      this.lineWidth,
      this.startAngle,
      this.sweepAngle,
      this.lines}) {
    startAngle ??= -pi / 4 * 3;
    sweepAngle ??= (-pi / 2);
    lines ??= 3;
  }

  Paint _paint;
  @override
  void paint(Canvas canvas, Size size) {
    _paint = Paint()
      ..strokeWidth = lineWidth ?? 4
      ..style = PaintingStyle.stroke
      ..color = this.color;
    double sep = 0.9 / lines;
    for (var i = 0; i < lines; ++i) {
      if (value > (0.9 - sep * i)) {
        _paint.color = this.color;
      } else {
        _paint.color = this.bgColor;
      }
      if (stop == true) {
        _paint.color = bgColor;
      }
      double wh = (1 - sep * i + sep);
      canvas.drawArc(
          Rect.fromCenter(
              center: Offset(size.width, size.height / 2),
              width: size.width * wh,
              height: size.height * wh),
          startAngle,
          sweepAngle,
          false,
          _paint);
    }
  }

  @override
  bool shouldRepaint(_CustomSoundWidget oldDelegate) {
    return oldDelegate.value != value ||
        this.stop != oldDelegate.stop ||
        oldDelegate.color != color ||
        oldDelegate.bgColor != bgColor;
  }
}
