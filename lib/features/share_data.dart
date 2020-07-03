import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/3.
///
class ShareData extends InheritedWidget {
  int count;
  ShareData({Key key, this.count, @required Widget child})
      : super(key: key, child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return this != oldWidget;
  }

  static ShareData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareData>();
  }

  static ShareData ofNoRefresh(BuildContext context) {
    return context.getElementForInheritedWidgetOfExactType<ShareData>().widget;
  }
}

class BaseShareData extends StatefulWidget {
  @override
  _BaseShareDataState createState() => _BaseShareDataState();
}

class _BaseShareDataState extends State<BaseShareData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('共享数据'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _count += 1;
          });
        },
      ),
    );
  }

  int _count = 0;
  Widget _body() {
    return ShareData(
      count: _count,
      child: Column(
        children: <Widget>[
          BaseShareData2(
            have: true,
            child: Row(
              children: <Widget>[
                BaseShareData2(
                  have: false,
                ),
                BaseShareData2(
                  have: false,
                )
              ],
            ),
          ),
          BaseShareData2(
            have: false,
            child: Row(
              children: <Widget>[
                BaseShareData2(
                  have: true,
                ),
                BaseShareData2(
                  have: false,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BaseShareData2 extends StatefulWidget {
  final bool have;
  final Widget child;
  BaseShareData2({this.have, this.child});
  @override
  _BaseShareData2State createState() => _BaseShareData2State();
}

class _BaseShareData2State extends State<BaseShareData2> {
  @override
  Widget build(BuildContext context) {
    print('build ${widget.have}');

    List<Widget> list = new List();
    list.add(Text(
      widget.have == false
          ? widget.have.toString()
          : ShareData.of(context).count.toString(),
      style: TextStyle(fontSize: 20),
    ));
    if (widget.child != null) {
      list.add(widget.child);
    }
    return Container(
      child: Column(
        children: list,
      ),
      alignment: Alignment.center,
    );
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
  }
}
