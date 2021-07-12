import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest01/page_view/page_view_custom.dart';

class CustomPageViewPage extends StatefulWidget {
  List<double> widgetHeights;
  int initPage;
  int pageCount;

  @override
  State<StatefulWidget> createState() => _CustomPageViewState();
  static String get routeName => '/page_view';
}

class _CustomPageViewState extends State<CustomPageViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                child: Text('我是第1行'),
                height: 200,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: _pageViewHeight,
                width: double.maxFinite,
                alignment: Alignment.center,
                child: CustomPageView(
                  widgetHeights: [100, 200, 300],
                  initPage: 1,
                  pageCount: 3,
                  itemBuilder: (ctx, index) {
                    return _item(index);
                  },
                  freshWidget: (fn) {
                    if (mounted) setState(fn);
                  },
                  freshHeightCallBack: (height) {
                    _pageViewHeight = height;
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Text('我是第二行'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('pageView'
            ''),
      ),
    );
  }

  Widget _item(int index) {
    print('build $index');
    index += 1;
    return Opacity(
      opacity: 1,
      child: Container(
        color: Colors.accents[index % Colors.accents.length],
        height: (index * 100).toDouble(),
        alignment: Alignment.center,
        child: Text('$index'),
      ),
    );
  }

  double _pageViewHeight;
  @override
  void initState() {
    super.initState();

    _pageViewHeight = 200;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
