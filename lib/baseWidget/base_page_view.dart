import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef FreshSuper = void Function(void Function() fn);
typedef FreshHeightCallBack = void Function(double height);

enum MovingDirection { left, right }

// ignore: must_be_immutable
class HotelPageView extends StatefulWidget {
  List<double> widgetHeights;
  int initPage;
  int pageCount;
  IndexedWidgetBuilder itemBuilder;
  FreshSuper freshWidget;
  FreshHeightCallBack freshHeightCallBack;
  PageController pageController;
  ScrollPhysics physics;
  Axis scrollDirection;
  final ValueChanged<int> onPageChanged;

  final bool opacityVisibility;

  HotelPageView(
      {@required this.widgetHeights,
      @required this.initPage,
      @required this.pageCount,
      @required this.itemBuilder,
      @required this.freshWidget,
      @required this.freshHeightCallBack,
      this.pageController,
      this.physics,
      this.opacityVisibility = true,
      this.onPageChanged,
      this.scrollDirection}) {
    assert(() {
      if ((widgetHeights?.length ?? 0) < pageCount) {
        return false;
      }
      return true;
    }(), '组件高度数量必须和页面数量一致 heights:${widgetHeights?.length} count:$pageCount');
    assert(() {
      if (itemBuilder == null ||
          freshWidget == null ||
          freshHeightCallBack == null) {
        return false;
      }
      return true;
    }(), 'itemBuilder 、freshHeightCallBack、freshWidget 是必须的');
    initPage ??= 0;
    // assert(() {
    //   if (initPage >= (widgetHeights?.length ?? 0) || initPage < 0) {
    //     return false;
    //   }
    //   return true;
    // }(), 'initPage 是范围有问题');
    pageController ??= PageController(initialPage: initPage ?? 0);
    physics ??= const BouncingScrollPhysics();
    scrollDirection ??= Axis.horizontal;
    widgetHeights ??= [];
  }

  @override
  State<StatefulWidget> createState() => _HotelPageViewState();
}

class _HotelPageViewState extends State<HotelPageView> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: Container(
        alignment: Alignment.center,
        child: Listener(
          child: NotificationListener<ScrollNotification>(
            child: Container(
              height: _pageViewHeight,
              width: double.maxFinite,
              alignment: Alignment.center,
              child: PageView.builder(
                  scrollDirection: widget.scrollDirection,
                  controller: _pageController,
                  itemCount: widget?.pageCount ?? 0,
                  physics: widget.physics,
                  onPageChanged: (index) {
                    _currentIndex = index;
                    print('index:$index');

                    // _pageController.animateToPage(index,
                    //     duration: Duration(milliseconds: 300),
                    //     curve: Curves.bounceIn);
                    //
                  },
                  // children: [_item(0), _item(1), _item(2)],
                  // childrenDelegate:
                  //     SliverChildListDelegate([_item(0), _item(1), _item(2)]),
                  // )
                  itemBuilder: (ctx, index) {
                    return Opacity(
                      opacity: widget?.opacityVisibility == true
                          ? (index == _nextIndex ? alpha : 1 - alpha)
                          : 1,
                      child: widget?.itemBuilder(ctx, index),
                    );
                  }),
            ),
            onNotification: (scr) {
              // print('notion:${_pageController.page.toString()}');
              return false;
            },
          ),
          onPointerUp: (touch) {
            _touching = false;
            print('onPointerUp ${touch.toString()}');
          },
        ),
      ),
      visible: (widget?.pageCount ?? 0) > 0 ||
          (widget?.widgetHeights?.isNotEmpty ?? false),
    );
  }

  int _currentIndex;
  int _nextIndex;
  double alpha;
  double _pageViewHeight;
  List<double> _heightList;
  PageController _pageController;
  MovingDirection movingDirection;
  double _oldOffset;
  bool _touching;
  @override
  void initState() {
    super.initState();

    alpha = 0;
    movingDirection = MovingDirection.right;

    _pageController = widget.pageController;
    _currentIndex = widget.initPage ?? 0;
    _nextIndex = _currentIndex + 1;
    _pageViewHeight = widget?.widgetHeights[widget?.initPage];

    _heightList = widget?.widgetHeights;
    if (widget?.freshHeightCallBack != null) {
      widget?.freshHeightCallBack(_pageViewHeight);
    }

    _pageController.addListener(() {
      var fr = () {
        if (_oldOffset == _pageController.page) {
          if (_touching != true) {
            _updateHeightToPageIndex(_currentIndex);
          }
          return;
        }
        _oldOffset = _pageController.page;
        _touching = true;
        //向左滑
        if (_pageController.page > _currentIndex) {
          _currentIndex = _pageController.page.floor();
          _nextIndex = _pageController.page.ceil();
          movingDirection = MovingDirection.left;
          _pageViewHeight = _heightList[_currentIndex] +
              (_heightList[_nextIndex] - _heightList[_currentIndex]) *
                  (_pageController.page - _currentIndex);
          alpha = (_pageController.page - _currentIndex);
        }
        //向右滑
        else if (_pageController.page < _currentIndex) {
          _currentIndex = _pageController.page.ceil();
          _nextIndex = _pageController.page.floor();
          movingDirection = MovingDirection.right;

          double currentMinPage = _pageController.page;
          // if (_pageController.page < _nextIndex.toDouble()) {
          //   currentMinPage = _nextIndex.toDouble();
          // }
          // currentMinPage = _pageController.page;

          _pageViewHeight = _heightList[_currentIndex] +
              (_heightList[_nextIndex] - _heightList[_currentIndex]) *
                  (_currentIndex - currentMinPage);
          alpha = (_currentIndex - currentMinPage);
        }
        if (alpha < 0) alpha = 0;
        if (alpha > 1.0) alpha = 1.0;
        if (alpha == double.nan) alpha = 0;
        if (widget?.freshHeightCallBack != null) {
          widget?.freshHeightCallBack(_pageViewHeight);
        }
      };
      if (widget?.freshWidget != null) {
        widget?.freshWidget(fr);
      }
    });
  }

  void _updateHeightToPageIndex(int index) {
    if (index < (widget?.widgetHeights?.length ?? 0)) {
      _pageViewHeight = widget?.widgetHeights[index];
      if (movingDirection == MovingDirection.left) {
        _nextIndex = -1;
        alpha = 0;
      } else if (movingDirection == MovingDirection.right) {
        _nextIndex = index + 1;
        alpha = 0;
      }
      if (widget?.freshHeightCallBack != null) {
        widget?.freshHeightCallBack(_pageViewHeight);
      }
    }
  }

  @override
  void dispose() {
    // _pageController?.dispose();
    super.dispose();
  }
}

class Stu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StuState();
  }

  final Widget child;
  Stu({Key key, this.child}) : super(key: key);
}

class _StuState extends State<Stu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}
