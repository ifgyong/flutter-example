import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest01/animation/base_animation_switch.dart';
import 'package:fluttertest01/tips/base_tabbar.dart';

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

  TabController _tabController;
  double _offset = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 1)
      ..addListener(() {
        setState(() {
          double of = _pageController.offset;
          _offset = of;
        });
//        print(_pageController.position.pixels);
//        print(
//            '${_pageController.offset - MediaQuery.of(context).size.width * _selectedIndex}');
      });
    _tabController = TabController(length: 6, vsync: this)
      ..addListener(() {
//        print(_tabController.index);
      });
    super.initState();
  }

  PageController _pageController;

  Widget _body() {
    return Center(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
//          Positioned(
//              top: -_top,
//              height: 55,
//              left: 0,
//              right: 0,
//              child: FlatButton(
//                child: Text(
//                  'push stop',
//                ),
//                onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (_) => FYTabbarWidget()));
//                },
//              )),
//          Positioned(
//              top: 55 - _top,
//              height: 55,
//              left: 0,
//              right: 0,
//              child: TabBar(
//                tabs: <Widget>[
//                  Container(
//                    alignment: Alignment.center,
////                    width: 100,
//                    child: Text(
//                      '推荐',
//                      style: _textStyle(0),
//                    ),
//                  ),
//                  Container(
//                    width: 100,
//                    child: Text(
//                      '热搜',
//                      style: _textStyle(1),
//                    ),
//                  ),
//                  Container(
//                    width: 100,
//                    child: Text(
//                      '本地',
//                      style: _textStyle(2),
//                    ),
//                  ),
//                  Container(
//                    width: 100,
//                    color: Colors.white70,
//                    child: Text(
//                      '新闻',
//                      style: _textStyle(3),
//                    ),
//                  )
//                ],
//                controller: _tabController,
//                onTap: (v) {
//                  _pageController.animateToPage(v,
//                      duration: Duration(milliseconds: 300),
//                      curve: Curves.linear);
//                },
//              )),
          Positioned(
            left: 0,
            right: 0,
            top: 110 - _top,
            height: 60,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                    child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: BaseFYTabBar(
                    offset: _offset,
                    initPageIndex: 1,
//                    pageIndex: _selectedIndex,
                    value: 0.3,
//                    lineColor: Colors.black,
                    titles: [
                      '推荐',
                      '上海',
                      '浦东',
                      '江苏',
                      '河南',
                      '湖北',
                      '浦东',
                      '徐汇',
                      '嘉定'
                    ],
                    maxTabsOfScreen: 2,
                  ),
                ))
              ],
              scrollDirection: Axis.horizontal,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 110 - _top + 60,
            child: //                SliverToBoxAdapter(
                Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              child: CupertinoScrollbar(
                  child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  _tabController.animateTo(index);
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: <Widget>[
                  _pageView(0),
                  _pageView(1),
                  _pageView(0),
                  _pageView(0),
                  _pageView(0),
                  _pageView(0),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }

  double _top = 0;
  Widget _pageView(int index) {
    return NotificationListener<ScrollNotification>(
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Container(
            width: 100,
            height: 50,
            color: Colors.primaries[index % Colors.primaries.length],
            child: Text('$index'),
          );
        },
        itemCount: 100,
      ),
      onNotification: (ScrollNotification n) {
        if (n.metrics.pixels < 0) {
          setState(() {
            _top = n.metrics.pixels;
          });
          print('$_top ${n.metrics.axisDirection}');
        }
        return false;
      },
    );
  }

  int _selectedIndex = 1;
  TextStyle _textStyle(int index) {
    return index != _selectedIndex
        ? TextStyle(
            color: Colors.blueAccent,
            fontSize: 15,
          )
        : TextStyle(
            color: Colors.red,
            fontSize: 20,
          );
  }

  Widget _tag(String tag, int index) {
    return SliverToBoxAdapter(
      child: Container(
        width: 100,
        height: 55,
        child: Text(
          tag ?? '',
          style: TextStyle(
              color: index == _selectedIndex ? Colors.red : Colors.black),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _Page extends StatefulWidget {
  final String title;
  bool selected;
  _Page({Key key, this.title, this.selected}) : super(key: key);

  @override
  __PageState createState() => __PageState();
}

class __PageState extends State<_Page> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return _tag(widget.title);
  }

  Widget _tag(
    String tag,
  ) {
    return SliverToBoxAdapter(
      child: Container(
        width: 100,
        height: 55,
        child: Text(
          tag ?? '',
          style: TextStyle(
              color: widget.selected == true ? Colors.red : Colors.black),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('${state.toString()} ${widget.title})');
    switch (state) {
      case AppLifecycleState.detached:
        print('detached');
        break;
      case AppLifecycleState.inactive:
        print('inactive');
        break;
      case AppLifecycleState.paused:
        print('paused');
        break;
      case AppLifecycleState.resumed:
        print('resumed');
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose()');
  }

  @override
  void reassemble() {
    print('reassemble');
    super.reassemble();
  }

  @override
  Future<bool> didPopRoute() {
    print('didPopRoute');
    return super.didPopRoute();
  }

  @override
  Future<bool> didPushRoute(String route) {
    print('didPushRoute');

    return super.didPushRoute(route);
  }
}
