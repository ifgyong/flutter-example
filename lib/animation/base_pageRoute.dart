import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/21.
///

class BasePageRoute extends StatefulWidget {
  BasePageRoute({Key key}) : super(key: key);

  @override
  _BasePageRouteState createState() => _BasePageRouteState();
}

class _BasePageRouteState extends State<BasePageRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('过度动画'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        children: <Widget>[
          OutlineButton(
            child: Text(
              'push 系统默认',
            ),
            onPressed: _pushDefault,
          ),
          OutlineButton(
            child: Text(
              'push 自定义路由切换动画 渐入动画',
            ),
            onPressed: _pushCustom,
          ),
          OutlineButton(
            child: Text(
              'push 自定义路由切换动画 大小',
            ),
            onPressed: _pushCustom2,
          ),
          OutlineButton(
            child: Text(
              'push 自己封装渐入 动画',
            ),
            onPressed: _push3,
          ),
        ],
      ),
    );
  }

  /// 默认动画
  void _pushDefault() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => PageB()));
  }

  /// 自定义动画
  void _pushCustom() {
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (BuildContext context, Animation<double> a1,
                Animation<double> a2) {
              return new FadeTransition(
                opacity: a1,
                child: PageB(),
              );
            }));
  }

  void _pushCustom2() {
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (BuildContext context, Animation<double> a1,
                Animation<double> a2) {
              return new ScaleTransition(
                scale: a1,
                child: PageB(),
              );
            }));
  }

  void _push3() {
    Navigator.push(
        context, FadeTransition2(pageBuilder: (context, a, b) => PageB()));
  }
}

class PageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.orangeAccent,
        ),
      ),
    );
  }
}

Widget _defaultTransitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return child;
}

class FadeTransition2 extends PageRoute {
  /// 自己实现转场的动画
  FadeTransition2({
    RouteSettings settings,
    @required this.pageBuilder,
    this.transitionsBuilder = _defaultTransitionsBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
    bool fullscreenDialog = false,
  })  : assert(pageBuilder != null),
        assert(transitionsBuilder != null),
        assert(opaque != null),
        assert(barrierDismissible != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  /// Used build the route's primary contents.
  ///
  /// See [ModalRoute.buildPage] for complete definition of the parameters.
  final RoutePageBuilder pageBuilder;

  /// Used to build the route's transitions.
  ///
  /// See [ModalRoute.buildTransitions] for complete definition of the parameters.
  final RouteTransitionsBuilder transitionsBuilder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return pageBuilder(context, animation, secondaryAnimation);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (isActive) {
      return FadeTransition(
        child: child,
        opacity: animation,
      );
    } else {
      return Padding(
        padding: EdgeInsets.zero,
        child: child,
      );
    }
  }
}
