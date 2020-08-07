import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef TabbarCallback = void Function(int index);

// ignore: must_be_immutable
class TabbarViewTWO extends StatefulWidget {
  TabbarCallback callback;
  int leftNumber;
  int rightNumber;
  String leftTitle;
  String rightTitle;

  Widget child;

  /// 高亮的索引
  final int hightIndex;

  TabbarViewTWO(
      {Key key,
      this.callback,
      @required this.leftTitle,
      @required this.rightNumber,
      @required this.rightTitle,
      @required this.leftNumber,
      this.child,
      this.hightIndex})
      : super(key: key);
  _TabbarViewState createState() => _TabbarViewState();
}

class _TabbarViewState extends State<TabbarViewTWO> {
  @override
  Widget build(BuildContext context) {
    return _topTab();
  }

  double _redLineLeft = 0;
  Widget _topTab() {
    _redLineLeft =
        MediaQuery.of(context).size.width / 2 * (widget.hightIndex ?? 0);
    GestureDetector c1 = GestureDetector(
        onTap: () {
          widget.callback(0);
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          alignment: Alignment.center,
          color: Colors.white,
          child: Text(widget.leftTitle,
              style: TextStyle(
                  color: _redLineLeft == 0
                      ? Theme.of(context).focusColor
                      : Colors.black26)),
        ));
    GestureDetector c2 = GestureDetector(
        onTap: () {
//          setState(() {
//            _redLineLeft = MediaQuery.of(context).size.width / 2;
//          });
          widget.callback(1);
        },
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width / 2,
          alignment: Alignment.center,
          child: Text(
            widget.rightTitle,
            style: TextStyle(
                color: _redLineLeft != 0
                    ? Theme.of(context).focusColor
                    : Colors.black26),
          ),
        ));
    Widget red1 = ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(7.5)),
      child: Container(
        color: Theme.of(context).focusColor,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 2, right: 2),
        child: Text(
          widget.rightNumber.toString(),
          style: TextStyle(fontSize: 10, color: Colors.white),
        ),
      ),
    );
//     红色的线
    Positioned pLine = Positioned(
        bottom: 0,
        left: _redLineLeft,
        child: Container(
          margin: EdgeInsets.only(top: 3),
          width: MediaQuery.of(context).size.width / 2,
          height: 1,
          color: Theme.of(context).focusColor,
        ));
    // 红色的数字
    Positioned p1_red = Positioned(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                height: widget.leftNumber == 0 ? 0 : 15,
                margin: EdgeInsets.only(left: 40),
                constraints: BoxConstraints(minWidth: 10, maxWidth: 20),
                child: red1,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                height: widget.rightNumber == 0 ? 0 : 15,
                margin: EdgeInsets.only(left: 60),
                constraints: BoxConstraints(minWidth: 10, maxWidth: 20),
                child: red1,
              ),
            ),
          )
        ],
      ),
      left: 0,
      right: 0,
      top: 10,
    );

    List<Positioned> list = [
      //文字
      Positioned(
        left: 0,
        right: 0,
        height: 40,
        top: 10,
        child: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[c1, c2],
          ),
        ),
      ),
      //红色的线
      p1_red,
      pLine,
    ];
    if (widget.child != null) {
      list.add(Positioned.fill(
        child: widget.child,
        top: 60,
      ));
    }
    Stack stack = Stack(
      children: list,
    );
    return stack;
  }
}
