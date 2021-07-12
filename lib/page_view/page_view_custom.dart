import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef FreshSuper = void Function(void Function() fn);
typedef FreshHeightCallBack = void Function(double height);

// ignore: must_be_immutable
class CustomPageView extends StatefulWidget {
  List<double> widgetHeights;
  int initPage;
  int pageCount;
  @required
  IndexedWidgetBuilder itemBuilder;
  FreshSuper freshWidget;
  FreshHeightCallBack freshHeightCallBack;
  final ValueChanged<int> onPageChanged;

  final bool opacityVisibility;

  CustomPageView(
      {@required this.widgetHeights,
      @required this.initPage,
      @required this.pageCount,
      @required this.itemBuilder,
      @required this.freshWidget,
      @required this.freshHeightCallBack,
      this.opacityVisibility = true,
      this.onPageChanged}) {
    assert(() {
      if ((widgetHeights?.length ?? 0) != pageCount) {
        return false;
      }
      return true;
    }(), '组件高度数量必须和页面数量一致');
    assert(() {
      if (itemBuilder == null ||
          freshWidget == null ||
          freshHeightCallBack == null) {
        return false;
      }
      return true;
    }(), 'itemBuilder 、freshHeightCallBack、freshWidget 是必须的');
    initPage ??= 0;
    assert(() {
      if (initPage >= (widgetHeights?.length ?? 0) || initPage < 0) {
        return false;
      }
      return true;
    }(), 'initPage 是范围有问题');
  }

  @override
  State<StatefulWidget> createState() => _CustomPageViewState();
  static String get routeName => '/page_view';
}

class _CustomPageViewState extends State<CustomPageView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: _pageViewHeight,
              width: double.maxFinite,
              alignment: Alignment.center,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget?.pageCount,
                onPageChanged: (index) {
                  _currentIndex = index;
                  if (widget?.onPageChanged != null)
                    widget?.onPageChanged(index);
                },
                itemBuilder: (ctx, index) {
                  return Opacity(
                    opacity: widget?.opacityVisibility == true
                        ? (index == _nextIndex ? alpha : 1 - alpha)
                        : 1,
                    child: widget?.itemBuilder(ctx, index),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _currentIndex;
  int _nextIndex;
  double alpha;
  double _pageViewHeight;
  List<double> _heightList;
  PageController _pageController;
  @override
  void initState() {
    super.initState();

    alpha = 0;

    _pageController = PageController(initialPage: widget?.initPage ?? 0);
    _currentIndex = widget.initPage ?? 0;
    _nextIndex = _currentIndex + 1;
    _pageViewHeight = widget?.widgetHeights[widget?.initPage];

    _heightList = widget?.widgetHeights;
    if (widget?.freshHeightCallBack != null) {
      widget?.freshHeightCallBack(_pageViewHeight);
    }
    _pageController.addListener(() {
      var fr = () {
        //向左滑
        if (_pageController.page > _currentIndex) {
          _currentIndex = _pageController.page.floor();
          _nextIndex = _pageController.page.ceil();
          _pageViewHeight = _heightList[_currentIndex] +
              (_heightList[_nextIndex] - _heightList[_currentIndex]) *
                  (_pageController.page - _currentIndex);
          alpha = (_pageController.page - _currentIndex);
        }
        //向右滑
        else if (_pageController.page < _currentIndex) {
          _currentIndex = _pageController.page.ceil();
          _nextIndex = _pageController.page.floor();
          _pageViewHeight = _heightList[_currentIndex] +
              (_heightList[_nextIndex] - _heightList[_currentIndex]) *
                  (_currentIndex - _pageController.page);
          alpha = (_currentIndex - _pageController.page);
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

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }
}
