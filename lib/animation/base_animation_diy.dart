import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/24.
///

class BaseDIYPage extends StatefulWidget {
  BaseDIYPage({Key key}) : super(key: key);

  @override
  _BaseDIYPageState createState() => _BaseDIYPageState();
}

class _BaseDIYPageState extends State<BaseDIYPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('过渡性组件'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Text('+'),
        onPressed: () {
          setState(() {});
        },
      ),
    );
  }

  int _key = 1;

  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BaseDIYAnimationSwitch(
            key: ObjectKey(_key),
            duration: Duration(
              milliseconds: 2000,
            ),
            reverseDuration: Duration(
              milliseconds: 3000,
            ),
            child: Container(
              color: Colors.red,
              width: 100,
              height: 100,
            ),
          ),
          OutlineButton(
            child: Text('更新key '),
            onPressed: () {
              setState(() {
                _key += 1;
              });
            },
          ),
          Row(
            children: <Widget>[
              AnimatedOpacity(
                opacity: _ope,
                duration: Duration(seconds: 3),
                child: Container(
                  color: _opColor,
                  width: 100,
                  height: 100,
                ),
              ),
              OutlineButton(
                child: Text('AnimatedOpacity'),
                onPressed: () {
                  setState(() {
//                    _opColor = _opColor == Colors.lightBlueAccent
//                        ? Colors.orange
//                        : Colors.lightBlueAccent;
                    _ope = _ope == 1 ? 0 : 1;
                  });
                },
              )
            ],
          ),
          Row(
            children: <Widget>[
              AnimatedPadding(
                padding: _padding,
                duration: Duration(seconds: 1),
                child: Container(
                  color: Colors.orange,
                  width: 100,
                  height: 100,
                ),
              ),
              OutlineButton(
                child: Text('AnimatedPadding'),
                onPressed: () {
                  setState(() {
                    _padding = _padding.left == _padding.right
                        ? EdgeInsets.only(
                            left: 30, right: 20, top: 20, bottom: 20)
                        : EdgeInsets.only(left: 10, right: 10);
                  });
                },
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                color: Colors.blue,
                width: 100,
                height: 100,
                child: AnimatedAlign(
                  alignment: _alignment,
                  duration: Duration(seconds: 1),
                  child: Text(
                    'align',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              OutlineButton(
                child: Text('AnimatedAlign'),
                onPressed: () {
                  setState(() {
                    _alignment = Alignment.bottomRight == _alignment
                        ? Alignment.topLeft
                        : Alignment.bottomRight;
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Color _opColor = Colors.red;
  double _ope = 0;
  EdgeInsets _padding = EdgeInsets.only(left: 10, right: 10);
  Alignment _alignment = Alignment.center;
}

class BaseDIYAnimationSwitch extends StatefulWidget {
  final Curve curve;
  final Duration duration, reverseDuration;
  final Widget child;

  BaseDIYAnimationSwitch(
      {Key key, this.curve, this.duration, this.child, this.reverseDuration})
      : super(key: key);

  @override
  _BaseDIYAnimationSwitchState createState() => _BaseDIYAnimationSwitchState();
}

class _BaseDIYAnimationSwitchState extends State<BaseDIYAnimationSwitch>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> animation;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: widget.duration,
        vsync: this,
        reverseDuration: widget.reverseDuration)
      ..forward();
    animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    super.initState();
  }

  @override
  void didUpdateWidget(BaseDIYAnimationSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateCurve();

    /// 当runType和 key有一个不一样的话再去更新动画
    if (Widget.canUpdate(oldWidget, widget) == false) {
      if (oldWidget.child != null) {
        _animationController.reverse();
      }

      _animationController
        ..duration = widget.duration
        ..reverseDuration = widget.reverseDuration;
      _animationController
        ..value = 0
        ..forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return AnimatedBuilder(
      child: widget.child,
      animation: animation,
      builder: (ctx, child) {
        return Opacity(
          opacity: animation.value,
          child: child,
        );
      },
    );
  }

  void _updateCurve() {
    if (widget.curve != null) {
      animation =
          CurvedAnimation(parent: _animationController, curve: widget.curve);
    } else {
      animation = _animationController;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class BaseAnimaitnAlign extends ImplicitlyAnimatedWidget {
  final Curve curve;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final Duration duration;

  final VoidCallback onEnd;
  const BaseAnimaitnAlign(
      {Key key,
      this.curve = Curves.linear,
      @required this.duration,
      this.onEnd,
      this.padding,
      this.child})
      : assert(curve != null),
        assert(duration != null),
        assert(child != null, ''),
        super(key: key, curve: curve, onEnd: onEnd, duration: duration);
  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return BaseAnimaitnAlignState();
  }
}

class BaseAnimaitnAlignState extends ImplicitlyAnimatedWidgetState<BaseAnimaitnAlign> {
  EdgeInsetsGeometryTween _padding;
  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _padding = visitor(
            _padding,
            widget.padding,
            (dynamic value) =>
                EdgeInsetsGeometryTween(begin: value as EdgeInsetsGeometry))
        as EdgeInsetsGeometryTween;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _padding
          .evaluate(animation)
          .clamp(EdgeInsets.zero, EdgeInsetsGeometry.infinity),
      child: widget.child,
    );
  }
}
