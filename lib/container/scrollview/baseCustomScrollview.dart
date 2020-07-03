import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest01/container/scrollview/baseListView.dart';

///
/// Created by fgyong on 2020/7/3.
///

class BaseCustomScrollView extends StatefulWidget {
  @override
  _BaseCustomScrollViewState createState() => _BaseCustomScrollViewState();
}

class _BaseCustomScrollViewState extends State<BaseCustomScrollView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    List<Widget> list = new List();
    for (int i = 0; i < 5; i++) {
      list.add(Card(
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Text('$i'),
        ),
      ));
    }

    return CupertinoScrollbar(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('flexibleSpace'),
              collapseMode: CollapseMode.parallax, //消失效果
              stretchModes: [StretchMode.fadeTitle], //消失效果
              background: PageView(
                children: <Widget>[
                  Container(
//                    color: Colors.orange,
                    alignment: Alignment.center,
                    child: Image.asset('img/2.png'),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset('img/2.png'),
                  ),
                  Container(
                    alignment: Alignment.center,
//                    color: Colors.orange,
                    child: Image.asset('img/2.png'),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset('img/2.png'),
                  ),
                ],
              ),
              centerTitle: true,
            ),
//            title: Text('12'),
            pinned: true,
//            snap: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(list),
          ),
          SliverGrid(
            delegate:
                SliverChildBuilderDelegate(_buildCell, childCount: list.length),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              width: 200,
              child: PageView(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 200,
                    alignment: Alignment.center,
                    child: Text(
                      '中间插画，可以左右滑动的哦！！！',
                      style: TextStyle(fontSize: 30),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.deepOrangeAccent, Colors.orange])),
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    alignment: Alignment.center,
                    child: Text(
                      '中间插画，可以左右滑动的哦！！！',
                      style: TextStyle(fontSize: 30),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.deepOrangeAccent, Colors.orange])),
                  )
                ],
              ),
            ),
          ),
          SliverGrid(
            delegate:
                SliverChildBuilderDelegate(_buildCell, childCount: list.length),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          ),
        ],
      ),
    );
  }

  Widget _buildCell(ctx, int index) {
    if (index < list.length - 1) {
      return Container(
        height: 80,
        alignment: Alignment.center,
        color: Colors.primaries[index % Colors.primaries.length],
        child: TestContainer(
          title: list[index],
        ),
      );
    } else if (list.length >= 30) {
      return Container(
        alignment: Alignment.center,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Icon(Icons.done), Text('没有更多数据了')],
        ),
      );
    } else {
      _getMoreData(); //加载数据
      return Container(
        alignment: Alignment.center,
        child: RefreshProgressIndicator(),
      );
    }
  }

  List<String> list;
  @override
  void initState() {
    list = new List();
    _getMoreData();
    super.initState();
  }

  void _getMoreData() async {
    await Future.delayed(Duration(milliseconds: 2000));

    setState(() {
      for (int i = 0; i < 10; i++) {
        list.add(DateTime.now().toString());
      }
    });
  }
}
