import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest01/baseWidget/base_page_view.dart';

class BasePageViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BaseSliderPageState();
  }

  static String get routeName => '/BasePageViewPage';
}

class _BaseSliderPageState extends State<BasePageViewPage> {
  @override
  void initState() {
    super.initState();
    _height = 100;
  }

  double _height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BaseSliderPageState'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text('滑动渐变pageView'),
            ),
            Container(
              alignment: Alignment.center,
              child: HotelPageView(
                widgetHeights: [100, 200, 150],
                pageCount: 3,
                initPage: 0,
                freshWidget: (fn) {
                  if (mounted) {
                    setState(fn);
                  }
                },
                freshHeightCallBack: (height) {
                  scheduleMicrotask(() {
                    if (mounted) {
                      setState(() {
                        _height = height;
                      });
                    }
                  });
                },
                itemBuilder: (ctx, index) {
                  double height = [100.0, 200.0, 160.0][index];

                  return Container(
                    height: height,
                    child: Container(
                      color:
                          Colors.accents[(index + 1) % Colors.accents.length],
                      height: height,
                    ),
                    color: Colors.accents[index % Colors.accents.length],
                  );
                },
              ),
              height: _height,
              width: 200,
            )
          ],
        ),
      ),
    );
  }
}
