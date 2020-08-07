import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest01/tips/Tabbar.dart';

///
/// Created by fgyong on 2020/8/3.
///
class BasePageViewRoute extends StatefulWidget {
  BasePageViewRoute({Key key}) : super(key: key);

  @override
  _BasePageViewRouteState createState() => _BasePageViewRouteState();
}

class _BasePageViewRouteState extends State<BasePageViewRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pageView'),
      ),
      body: _body(),
    );
  }

  int hightIndex = 0;
  Widget _body() {
    return TabbarViewTWO(
      callback: _changeIndex,
      hightIndex: hightIndex,
      child: PageView(
        pageSnapping: true,
        controller: _pageController,
        onPageChanged: (index) {
          _pageController.jumpToPage(index);
        },
        children: <Widget>[
          Text('1'),
          Text('2'),
        ],
      ),
      leftTitle: 'left',
      rightTitle: 'right',
      leftNumber: 0,
      rightNumber: 0,
    );
  }

  void _changeIndex(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      hightIndex = index;
    });
  }

  PageController _pageController;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }
}
