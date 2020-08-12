import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/8/10.
///

// ignore: must_be_immutable
class BaseFYTabBar extends StatefulWidget {
  double offset;
  List<String> titles;

  ///
  int initPageIndex;

  /// 线条的宽度倍数 [0.1,1]
  double value;

  /// 线的高度
  double lineHeight;
  double tabHeight;
  Color lineColor;

  /// 屏幕最大包含个数
  int maxTabsOfScreen;

  /// 默认文字样式
  TextStyle style;

  /// 高亮文字样式
  TextStyle hlightStyle;

  BaseFYTabBar({
    Key key,
    this.offset,
    @required this.titles,
    @required this.maxTabsOfScreen,
    this.initPageIndex = 0,
    this.value = 0.5,
    this.lineHeight = 2,
    this.tabHeight = 55,
    this.lineColor = Colors.red,
    this.style,
    this.hlightStyle,
  }) : super(key: key) {
//    assert((value >= 0.1 && value <= 1.0), 'value 范围是[0.1,1.0]');

    assert(titles != null, 'titles is null');
    assert(offset != null, 'offset is null');
    hlightStyle ??= TextStyle(fontSize: 18, color: Colors.red);
  }
  @override
  _BaseFYTabbarState createState() => _BaseFYTabbarState();
}

class _BaseFYTabbarState extends State<BaseFYTabBar> {
  bool _isFirstBuild = true;
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  double _width = 0;
  int get tabs => widget.titles.length;
  int get maxTabsOfScreen => widget.maxTabsOfScreen ?? 4;
  double _lineLeftOffset;
  Widget _body() {
    double w = MediaQuery.of(context).size.width / maxTabsOfScreen;
    double widthOfScreen = MediaQuery.of(context).size.width;
    int pages = (widget.offset / widthOfScreen).floor();
    int _isCurrentPageIndex = (widget.offset / widthOfScreen).round();
    if (_isFirstBuild) {
      _isFirstBuild = false;
      pages = widget.initPageIndex;
    }

    List<Widget> list = List();
    for (int i = 0; i < widget.titles.length; i++) {
      bool _isCurrentPage = i == _isCurrentPageIndex;

      list.add(SliverToBoxAdapter(
        child: Container(
          alignment: Alignment.center,
          width: w,
          child: Text(
            widget.titles[i],
            style: _isCurrentPage ? widget.hlightStyle : TextStyle(),
          ),
        ),
      ));
    }

    double _leftMargin = w * (1 - widget.value) * 0.5,
        _defaultWidth = w * widget.value,
        _currentPageOffset =
            (widget.offset.toInt() % widthOfScreen.toInt()).toDouble();
    _lineLeftOffset = pages * w;
    if (_currentPageOffset > widthOfScreen / 2) {
      _currentPageOffset -= widthOfScreen / 2;
      _lineLeftOffset = pages * w + _leftMargin;
      _lineLeftOffset += _currentPageOffset / widthOfScreen * 2 * w;

      /// 偏移量
      double of = _currentPageOffset * 2 / widthOfScreen * _defaultWidth;

      _width = _defaultWidth + _defaultWidth - of;
    } else {
      _width = _defaultWidth +
          _currentPageOffset * 2 / widthOfScreen * _defaultWidth;
      _lineLeftOffset = pages * w + _leftMargin;
    }
    print(
        'left:${_lineLeftOffset.toInt()}  width:${_width.toInt()} offset:${widget.offset.toInt()}');
    _isFirstBuild = false;

    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          height: widget.tabHeight,
          child: CupertinoScrollbar(
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: list,
            ),
          ),
        ),
        Positioned(
          left: _lineLeftOffset,
          width: _width,
          height: widget.lineHeight,
          top: widget.tabHeight - widget.lineHeight,
          child: Container(
            height: widget.lineHeight,
            width: _width,
            color: widget.lineColor,
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    _isFirstBuild = true;
    super.initState();
  }
}
